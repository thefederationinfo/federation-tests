export btf=$(basename $BATS_TEST_FILENAME)
export curl_params="/tmp/curl_params"

unset HTTP_STATUS_CODE
unset HTTP_BODY

# will run on every test and
# verify installed dependencies
function setup() {
  # postgresql client
  command -v psql
  [ "$?" -eq 0 ]
  # curl http client
  command -v curl
  [ "$?" -eq 0 ]
  # json parser
  command -v jq
  [ "$?" -eq 0 ]
  # git binary
  command -v git
  [ "$?" -eq 0 ]
}

# fetch "POST" "data1=one&data2=two" "http://server/endpoint"
function fetch() {
  tmp=$(mktemp)

  unset params
  [ -f "$curl_params" ] && params=$(cat $curl_params)
  [ "$2" != "" ] && params="$params -d '$2'"
  params="$params -k -D $tmp -s -X $1"

  export HTTP_BODY=$(eval "curl $params $3")
  export HTTP_STATUS_CODE=$(head -n1 $tmp |cut -d' ' -f2)
  echo "curl = '$params $3'"
  echo "HTTP_STATUS_CODE = $HTTP_STATUS_CODE"
  echo "HTTP_BODY = $HTTP_BODY"

  rm -v $tmp
  [ "$?" -eq 0 ]
}

# post "data1=one&data2=two" "http://server/endpoint"
function post() {
  fetch "POST" "$1" "$2"
}

# get "http://server/endpoint?data1=one&data2=two"
function get() {
  fetch "GET" "" "$1"
}

# start_app "g1" "3000" "testing_diaspora:v1.0.1"
function start_app() {
  params=""
  if [ ! -z ${PRSHA} ]; then
    echo "!!!!!!! Custom build active !!!!!!!"
    echo "Using repository $PRREPO"
    echo "With SHA $PRSHA"
    params="-e PRSHA=$PRSHA -e PRREPO=$PRREPO"
  fi
  docker run --name=$1 $params -e DATABASE=$1 -e PORT=$2 -p $2:$2 --net=host -d thefederation/$3
}

# stop_app "g1"
function stop_app() {
  docker stop $1
}

# remove_app "g1"
function remove_app() {
  docker rm $1
}

# wait_for_mastodon "m1"
function wait_for_mastodon() {
  instance=$1
  function cmd() {
    docker logs $instance 2>&1 |grep 'webpack: Compiled successfully' |wc -l
  }
  wait_for cmd "2"
}

# wait_for "docker logs g1" "Listening on" 120
function wait_for() {
  timeout=500
  if [[ "$3" =~ ^[0-9]+$ ]] ; then
    timeout=$3
  fi
  command -v $1 >/dev/null
  if [ "$?" -ne 0 ]; then echo 1; return; fi

  i=0; while true; do
    if [ "$i" -gt "$timeout" ]; then break; fi
    ((i++))
    sleep 1
  done & >/dev/null 2>&1
  TIMEOUT_PID=$!

  while true; do
    $1 |grep -m 1 "$2" >/dev/null 2>&1
    if [ "$?" -eq 0 ]; then break; fi
    sleep 1
  done & >/dev/null 2>&1
  CMD_PID=$!

  while true; do
    # check timeout child
    kill -0 $TIMEOUT_PID >/dev/null 2>&1
    if [ "$?" -gt 0 ]; then
      kill -9 $CMD_PID
      echo 1
      break
    fi
    # check cmd child
    kill -0 $CMD_PID >/dev/null 2>&1
    if [ "$?" -gt 0 ]; then
      kill -9 $TIMEOUT_PID
      echo 0
      break
    fi
    sleep 1
  done
}

# query "g1" "select count(*) from posts;"
function query() {
  psql -t -d $1 -U postgres -c "$2" |tr -d '\n\r '
}

# json_value "ID"
function json_value() {
  echo $HTTP_BODY | jq -r ".$1"
}

# latest_tag "diaspora"
function latest_tag() {
  git tag |sort -r |while read tag; do
    label=$(echo $tag |cut -d- -f2)
    if [ "$label" == "$1" ]; then
      echo $tag
      break
    fi
  done
}

# rails_runner "d1" "puts 'Hello World!'"
function rails_runner() {
  docker exec $1 bundle exec rails runner "$2"
}

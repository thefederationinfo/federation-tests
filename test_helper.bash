export btf=$(basename $BATS_TEST_FILENAME)

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

curl_params="/tmp/curl_params"
# fetch "POST" "data1=one&data2=two" "http://server/endpoint"
function fetch() {
  tmp=$(mktemp)
  [ -f "$curl_params" ] && params=$(cat $curl_params)
  [ "$2" != "" ] && params="$params -d $2"
  params="$params -s -O /dev/null -o $tmp -X $1 -w %{http_code}"
  echo "exec: curl $params $3"
  export HTTP_STATUS_CODE=$(curl $params $3)
  export HTTP_BODY=$(cat $tmp)
  rm $tmp
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
  docker run --name=$1 -e DATABASE=$1 -e PORT=$2 -p $2:$2 --net=host -d thefederation/$3
}

# stop_app "g1"
function stop_app() {
  docker stop $1
}

# remove_app "g1"
function remove_app() {
  docker rm $1
}

# wait_for "docker logs g1" "Listening on" 120
function wait_for() {
  timeout=500
  if [[ $3 =~ '^[0-9]+$' ]] ; then
    timeout=$3
  fi
  command -v $1 >/dev/null
  if [ "$?" -ne 0 ]; then echo 1; return; fi
  while true; do
    $1 |grep -m 1 "$2" >/dev/null
    if [ "$?" -eq 0 ]; then echo 0; break; fi
    if [ "$i" -eq $timeout ]; then echo 1; break; fi
    ((i++))
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
      return
    fi
  done
  echo null
}

# rails_runner "d1" "puts 'Hello World!'"
function rails_runner() {
  docker exec $1 bundle exec rails runner "$2"
}

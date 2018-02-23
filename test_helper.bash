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

# wait_for "docker logs g1" "Listening on"
function wait_for() {
  while true; do
    eval "$1" |grep -m 1 "$2" >/dev/null
    if [ "$?" -eq 0 ]; then echo 0; break; fi
    if [ "$i" -eq 300 ]; then echo 1; break; fi
    ((i++))
    sleep 2
  done
}

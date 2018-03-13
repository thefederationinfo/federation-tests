# socialhome_start_server "s1" "9001"
function socialhome_start_server() {
  start_app "$1" "$2" "testing_socialhome"$(latest_tag "socialhome")
  [ "$?" -eq 0 ]
  code=$(wait_for "docker logs $1" "Listening on endpoint tcp")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
}

# socialhome_create_user "s1"
function socialhome_create_user() {
  # create superuser via python console
  echo "from django.contrib.auth import get_user_model;
User = get_user_model();
User.objects.create_superuser(
  '$1', 's1@example.com', 'pppppp'
);" |docker exec $1 python manage.py shell -c "$(cat -)"
}

# socialhome_fetch_token "s1" "http://localhost:9001"
function socialhome_fetch_token() {
  post_form "username=$1&password=pppppp" "$2/api-token-auth/"
  [ "$?" -eq 0 ]
  #echo "expected 200, got $HTTP_STATUS_CODE"
  #[ "$HTTP_STATUS_CODE" == "200" ]
  token=$(json_value "token")
  echo "body = $HTTP_BODY"
  echo "token = $token"
  [ "$token" != "null" ]
  echo "-H 'Authorization: Token $token'" > $curl_params
}

# socialhome_start_sharing "g1@localhost:9000" "http://localhost:9001"
function socialhome_start_sharing() {
  # search remote profile first
  get "$2/search/?q=$1"
  [ "$?" -eq 0 ]
  [ "$HTTP_STATUS_CODE" == "302" ]
  sleep 5
  # start following
  user=$(echo $1 |cut -d'@' -f1)
  guid=$(query "$user" "select guid from people where author = '$1';")
  [ "$?" -eq 0 ]
  echo "guid = $guid"
  [ "$guid" != "" ]
  post "guid=$guid" "$2/api/profiles/1/add_follower/"
  [ "$?" -eq 0 ]
  sleep 5
}

# ganggo_start_server "g1" "9000"
function ganggo_start_server() {
  start_app "$1" "$2" "testing_ganggo"$(latest_tag "ganggo")
  [ "$?" -eq 0 ]
  code=$(wait_for "docker logs $1" "Listening on")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
}

# ganggo_create_user "g1" "http://localhost:9000"
function ganggo_create_user() {
  post "username=$1&password=pppppp&confirm=pppppp" "$2/users/sign_up"
  echo "expected 302, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "302" ]
}

# ganggo_fetch_token "g1" "http://localhost:9000"
function ganggo_fetch_token() {
  post "grant_type=password&username=$1&password=pppppp&client_id=bats" \
       "$2/api/v0/oauth/tokens"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  token=$(json_value "token")
  echo "body = $HTTP_BODY"
  echo "token = $token"
  [ "$token" != "null" ]
  echo "-H access_token:$token" > $curl_params
}

# ganggo_start_sharing "g2@localhost:9001" "http://localhost:9000"
function ganggo_start_sharing() {
  # search and discover a person
  post "handle=$1" "$2/api/v0/search"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  personID=$(json_value "ID")
  echo "body = $HTTP_BODY"
  echo "personID = $personID"
  [ "$personID" -gt 0 ]
  # create a new aspect
  post "aspect_name=test" "$2/api/v0/aspects"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  aspectID=$(json_value "ID")
  echo "body = $HTTP_BODY"
  echo "aspectID = $aspectID"
  [ "$aspectID" -gt 0 ]
  # start sharing with person
  post "" "$2/api/v0/people/$personID/aspects/$aspectID"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
}

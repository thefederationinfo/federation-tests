# vim:ft=sh

load test_helper

endpoint="http://localhost:3000"

@test "$btf start mastodon#1 server" {
  start_app "m1" "3000" "testing_mastodon"$(latest_tag "mastodon")
  [ "$?" -eq 0 ]
  code=$(wait_for_mastodon "m1")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
}

@test "$btf start mastodon#2 server" {
  start_app "m2" "3001" "testing_mastodon"$(latest_tag "mastodon")
  [ "$?" -eq 0 ]
  code=$(wait_for_mastodon "m2")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
}

# see https://github.com/tootsuite/documentation/blob/master/Using-the-API/Testing-with-cURL.md
@test "$btf create oauth application" {
  post "client_name=bats&redirect_uris=urn:ietf:wg:oauth:2.0:oob&scopes=read%20write%20follow" "$endpoint/api/v1/apps"
  [ "$HTTP_STATUS_CODE" == "200" ]
  client_id=$(json_value "client_id")
  [ "$client_id" != "" ]
  client_secret=$(json_value "client_secret")
  [ "$client_secret" != "" ]

  post "client_id=$client_id&client_secret=$client_secret&grant_type=password&username=admin@localhost:3000&password=mastodonadmin&scope=read%20write%20follow" "$endpoint/oauth/token"
  [ "$HTTP_STATUS_CODE" == "200" ]
  token=$(json_value "access_token")
  echo "token = $token"
  [ "$token" != "" ]
  echo "-H 'Authorization: Bearer $token'" > $curl_params
}

@test "$btf follow admin@localhost:3001" {
  post "uri=admin@localhost:3001" "$endpoint/api/v1/follows"
  post "uri=admin@localhost:3001" "$endpoint/api/v1/follows"
  echo "HTTP_STATUS_CODE = $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  username=$(json_value "username")
  [ "$username" != "" ]
  [ "$username" == "admin" ]
}

@test "$btf search for admin@localhost:3001" {
  get "$endpoint/api/v1/search?q=admin@localhost:3001"
  echo "HTTP_STATUS_CODE = $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  echo "HTTP_BODY = $HTTP_BODY"
  acct=$(echo $HTTP_BODY |jq -r '.accounts[] | select(.username == "admin") | .acct')
  [ "$acct" != "" ]
  [ "$acct" == "admin@localhost:3001" ]
}

@test "$btf clean-up containers, databases and temp files" {
  stop_app "m1 m2"
  [ "$?" -eq 0 ]
  remove_app "m1 m2"
  [ "$?" -eq 0 ]
  psql -U postgres -c "drop database m1;"
  [ "$?" -eq 0 ]
  rm -v $curl_params
  [ "$?" -eq 0 ]
}

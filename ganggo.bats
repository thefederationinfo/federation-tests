#!/usr/bin/env bats

load test_helper

endpoint="http://localhost:9000"

@test "curl and psql client exists" {
  command -v psql
  [ "$?" -eq 0 ]
  command -v curl
  [ "$?" -eq 0 ]
}

@test "create database" {
  psql -U postgres -c "create database g1;"
  [ "$?" -eq 0 ]
}

@test "start ganggo#1 server" {
  start_app "g1" "9000" "testing_ganggo:v1.0.0-ganggo"
  [ "$?" -eq 0 ]
  code=$(wait_for "docker logs g1" "Listening on")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
}

@test "start diaspora#1 server" {
  start_app "d1" "3000" "testing_diaspora:v1.0.3-diaspora"
  [ "$?" -eq 0 ]
  code=$(wait_for "docker logs d1" "Starting Diaspora in production")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
  # unicorn timeout
  sleep 15
}

@test "create user" {
  post "username=g1&password=pppppp&confirm=pppppp" "$endpoint/users/sign_up"
  echo "expected 302, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "000302" ]
}

# according to https://ganggo.github.io/api/#api-Oauth-ApiOAuth_Create
@test "fetch user token" {
  post "grant_type=password&username=g1&password=pppppp&client_id=bats" \
       "$endpoint/api/v0/oauth/tokens"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "000200" ]
  token=$(echo $HTTP_BODY |cut -d'"' -f 4)
  echo "body = $HTTP_BODY"
  echo "token = $token"
  [ "$token" != "" ]
  echo "-H access_token:$token" > $curl_params
}

@test "setup user relations" {
  # search and discover a person
  post "handle=d1@localhost:3000" "$endpoint/api/v0/search"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "000200" ]
  personID=$(echo $HTTP_BODY |sed -r 's/.*"ID":\s*([0-9]+),.*/\1/g')
  echo "body = $HTTP_BODY"
  echo "personID = $personID"
  [ "$personID" -gt 0 ]
  # create a new aspect
  post "aspect_name=test" "$endpoint/api/v0/aspects"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "000200" ]
  aspectID=$(echo $HTTP_BODY |sed -r 's/.*"ID":\s*([0-9]+),.*/\1/g')
  echo "body = $HTTP_BODY"
  echo "aspectID = $aspectID"
  [ "$aspectID" -gt 0 ]
  # start sharing with person
  post "" "$endpoint/api/v0/people/$personID/aspects/$aspectID"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "000200" ]
}

@test "create post and check federation" {
  # create post via ganggo
  post "post=helloworld&aspectID=0" "$endpoint/api/v0/posts"
  echo "expected 200, got $HTTP_STATUS_CODE"
  echo "body = $HTTP_BODY"
  [ "$HTTP_STATUS_CODE" == "000200" ]

  # check post in diaspora
  cmd="psql -t -d d1 -U postgres -c 'select count(*) from posts;' |tr -d '\n\r '"
  code=$(wait_for $cmd "1")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]

#  values.Set("comment", msg)
#  t.POST(fmt.Sprintf(
#    "/api/v0/posts/%d/comments", post.ID), values)

}

@test "stop and delete containers" {
  stop_app "g1 d1"
  [ "$?" -eq 0 ]
  remove_app "g1 d1"
  [ "$?" -eq 0 ]
}

@test "drop databases" {
  psql -U postgres -c "drop database g1;"
  [ "$?" -eq 0 ]
  psql -U postgres -c "drop database d1;"
  [ "$?" -eq 0 ]
}

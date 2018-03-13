# vim:ft=sh
#
# All API calls are documented here: https://ganggo.github.io/api/
#

load test_helper
load ganggo_helper

endpoint="http://localhost:9000"

@test "$btf create database" {
  psql -U postgres -c "create database g1;"
  [ "$?" -eq 0 ]
}

@test "$btf start ganggo#1 server" {
  ganggo_start_server g1 "9000"
}

@test "$btf start diaspora#1 server" {
  start_app "d1" "3000" "testing_diaspora"$(latest_tag "diaspora")
  [ "$?" -eq 0 ]
  code=$(wait_for "docker logs d1" "Starting Diaspora in production")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
  # unicorn timeout
  sleep 15
}

@test "$btf create user" {
  ganggo_create_user g1 $endpoint
}

@test "$btf create diaspora user" {
  skip "exists already"
}

@test "$btf fetch user token" {
  ganggo_fetch_token g1 $endpoint
}

@test "$btf setup user relations" {
  ganggo_start_sharing "d1@localhost:3000" $endpoint
}

function send_type() {
  type=$1

  aspectID=0
  [ "$type" == "private" ] && aspectID=1

  # create post via ganggo
  post "post=helloworld&aspectID=$aspectID" "$endpoint/api/v0/posts"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  postID=$(json_value "ID")
  echo "body = $HTTP_BODY"
  echo "postID = $postID"
  [ "$postID" -gt 0 ]
  guid=$(json_value "Guid")
  echo "guid = $guid"
  [ "$guid" != "null" ]
  # check post in diaspora
  function cmd() {
    public="true"
    [ "$type" == "private" ] && public="false"
    query "d1" "select count(*) from posts
                where guid = '$guid' and public = $public;"
  }
  code=$(wait_for cmd "1" 120)
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]

  # create comment
  post "comment=hellod1" "$endpoint/api/v0/posts/$postID/comments"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  guid=$(json_value "Guid")
  echo "body = $HTTP_BODY"
  echo "guid = $guid"
  [ "$guid" != "null" ]
  # check comment
  function cmd() {
    query "d1" "select count(*) from comments
                where guid = '$guid';"
  }
  code=$(wait_for cmd "1" 120)
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]

  # create like
  post "" "$endpoint/api/v0/posts/$postID/likes/true"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  guid=$(json_value "Guid")
  echo "body = $HTTP_BODY"
  echo "guid = $guid"
  [ "$guid" != "null" ]
  # check like
  function cmd() {
    query "d1" "select count(*) from likes
                where guid = '$guid';"
  }
  code=$(wait_for cmd "1" 120)
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
}

@test "$btf create public entities and check federation" {
  send_type public
}

@test "$btf create private entities and check federation" {
  send_type private
}

@test "$btf stop and delete containers" {
  stop_app "g1 d1"
  [ "$?" -eq 0 ]
  remove_app "g1 d1"
  [ "$?" -eq 0 ]
}

@test "$btf drop databases" {
  psql -U postgres -c "drop database g1;"
  [ "$?" -eq 0 ]
  psql -U postgres -c "drop database d1;"
  [ "$?" -eq 0 ]
}

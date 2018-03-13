# vim:ft=sh
#
# All API calls are documented here: https://ganggo.github.io/api/
#

load test_helper
load ganggo_helper

g1endpoint="http://localhost:9000"
g2endpoint="http://localhost:9001"

@test "$btf create databases" {
  psql -U postgres -c "create database g1;"
  [ "$?" -eq 0 ]
  psql -U postgres -c "create database g2;"
  [ "$?" -eq 0 ]
}

@test "$btf start ganggo#1 server" {
  ganggo_start_server g1 "9000"
}

@test "$btf start ganggo#2 server" {
  ganggo_start_server g2 "9001"
}

@test "$btf create user#1" {
  ganggo_create_user g1 $g1endpoint
}

@test "$btf create user#2" {
  ganggo_create_user g2 $g2endpoint
}

@test "$btf fetch user#1 token" {
  ganggo_fetch_token g1 $g1endpoint
}

@test "$btf setup user relations" {
  ganggo_start_sharing "g2@localhost:9001" $g1endpoint
}

function send_type() {
  type=$1

  aspectID=0
  [ "$type" == "private" ] && aspectID=1

  # create post via ganggo
  post "post=helloworld&aspectID=$aspectID" "$g1endpoint/api/v0/posts"
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
    query "g2" "select count(*) from posts
                where guid = '$guid' and public = $public;"
  }
  code=$(wait_for cmd "1" 120)
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]

  # create comment
  post "comment=hellod1" "$g1endpoint/api/v0/posts/$postID/comments"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  guid=$(json_value "Guid")
  echo "body = $HTTP_BODY"
  echo "guid = $guid"
  [ "$guid" != "null" ]
  # check comment
  function cmd() {
    query "g2" "select count(*) from comments
                where guid = '$guid';"
  }
  code=$(wait_for cmd "1" 120)
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]

  # create like
  post "" "$g1endpoint/api/v0/posts/$postID/likes/true"
  echo "expected 200, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "200" ]
  guid=$(json_value "Guid")
  echo "body = $HTTP_BODY"
  echo "guid = $guid"
  [ "$guid" != "null" ]
  # check like
  function cmd() {
    query "g2" "select count(*) from likes
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
  stop_app "g1 g2"
  [ "$?" -eq 0 ]
  remove_app "g1 g2"
  [ "$?" -eq 0 ]
}

@test "$btf drop databases" {
  psql -U postgres -c "drop database g1;"
  [ "$?" -eq 0 ]
  psql -U postgres -c "drop database g2;"
  [ "$?" -eq 0 ]
}

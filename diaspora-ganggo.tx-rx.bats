#!/usr/bin/env bats

load test_helper

gngg_endpnt="http://localhost:9000"

@test "$btf create database" {
  psql -U postgres -c "create database g1;"
  [ "$?" -eq 0 ]
}

@test "$btf start ganggo#1 server" {
  start_app "g1" "9000" "testing_ganggo:"$(latest_tag "ganggo")
  [ "$?" -eq 0 ]
  code=$(wait_for "docker logs g1" "Listening on")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
}

@test "$btf start diaspora#1 server" {
  start_app "d1" "3000" "testing_diaspora:"$(latest_tag "diaspora")
  [ "$?" -eq 0 ]
  code=$(wait_for "docker logs d1" "Starting Diaspora in production")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
  # unicorn timeout
  sleep 15
}

@test "$btf create ganggo user" {
  post "username=g1&password=pppppp&confirm=pppppp" "$gngg_endpnt/users/sign_up"
  echo "expected 302, got $HTTP_STATUS_CODE"
  [ "$HTTP_STATUS_CODE" == "000302" ]
}

@test "$btf create diaspora user" {
  skip "exists already"
}

@test "$btf setup user relations" {
  rails_runner "d1" "user = User.find_by(username: 'd1');
                person = Person.find_or_fetch_by_identifier('g1@localhost:9000');
                Aspect.find_each {|obj| user.share_with(person, obj)};"
  [ "$?" -eq 0 ]
}

function send_type() {
  type=$1

  # should we send it publicly or limited
  if [ "$type" == "private" ]; then
    postType="public: false, aspect_ids: aspectIds"
  else
    postType="public: true"
  fi
  # send post via diaspora
  postID=$(rails_runner "d1" "user = User.find_by(username: 'd1');
            aspectIds = Aspect.find_each.collect {|obj| obj.id if obj.user_id == 1 }
            puts StatusMessageCreationService.new(user).create(
              status_message: {text: 'hello world'}, $postType
            ).id;")
  echo "postID = $postID"
  [ "$?" -eq 0 ]
  [ "$postID" -gt 0 ]

  # check if ganggo received it
  function cmd() {
    query "g1" "select count(*) from posts where public = true;"
  }
  code=$(wait_for cmd "1")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]

  # send comment
  guid=$(rails_runner "d1" "user = User.find_by(username: 'd1');
          puts CommentService.new(user)
            .create($postID, 'commenttext').guid;")
  echo "guid = $guid"
  [ "$?" -eq 0 ]
  # XXX how to check guid
  #[ "$guid" != "null" ]

  # check comment
  function cmd() {
    query "g1" "select count(*) from comments where guid = '$guid';"
  }
  code=$(wait_for cmd "1")
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]

  # send like
  guid=$(rails_runner "d1" "user = User.find_by(username: 'd1');
          puts LikeService.new(user).create($postID).guid;")
  echo "guid = $guid"
  [ "$?" -eq 0 ]
  # XXX how to check guid
  #[ "$guid" != "null" ]

  # check comment
  function cmd() {
    query "g1" "select count(*) from likes where guid = '$guid';"
  }
  code=$(wait_for cmd "1")
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

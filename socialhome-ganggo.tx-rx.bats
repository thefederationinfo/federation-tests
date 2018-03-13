# vim:ft=sh
#
# All API calls are documented here: https://ganggo.github.io/api/
#

load test_helper
load ganggo_helper
load socialhome_helper

endpoint="localhost:9001"
web_endpoint="http://$endpoint"
g1_endpoint="http://localhost:9000"

@test "$btf create databases" {
  psql -U postgres -c "create database g1;"
  [ "$?" -eq 0 ]
  psql -U postgres -c "create database s1;"
  [ "$?" -eq 0 ]
}

@test "$btf start ganggo#1 server" {
  ganggo_start_server g1 "9000"
}

@test "$btf start socialhome#1 server" {
  socialhome_start_server s1 "9001"
}

@test "$btf create ganggo#1 user" {
  ganggo_create_user g1 $g1_endpoint
}

@test "$btf create socialhome#1 user" {
  socialhome_create_user s1
}

# since socialhome only delivers to subscriped servers
# the ganggo user has to follow the socialhome user
@test "$btf fetch ganggo#1 token" {
  ganggo_fetch_token g1 $g1_endpoint
}

@test "$btf setup user relations" {
  ganggo_start_sharing "s1@localhost:9001" $g1_endpoint
}

# otherwise the socialhome token request will fail
@test "$btf clean-up ganggo#1 files" {
  rm -v $curl_params
  [ "$?" -eq 0 ]
}

# according to http://socialhome.readthedocs.io/en/latest/api.html#authenticating
@test "$btf fetch socialhome#1 token" {
  socialhome_fetch_token s1 $web_endpoint
}

@test "$btf start sharing" {
  socialhome_start_sharing "g1@localhost:9000" $web_endpoint
}

@test "$btf create public entities and check federation" {
  post "text=foobar&visibility=public" "$web_endpoint/api/content/"
  [ "$?" -eq 0 ]
  guid=$(json_value "guid")
  echo "guid = $guid"
  [ "$guid" != "" ]
  # check post in ganggo
  function cmd() {
    query "g1" "select count(*) from posts
                where guid = '$guid' and public = true;"
  }
  code=$(wait_for cmd "1" 120)
  echo "expected 0, got $code"
  [ "$code" -eq "0" ]
}

@test "$btf clean-up files, containers and database" {
  stop_app "g1 s1"
  [ "$?" -eq 0 ]
  remove_app "g1 s1"
  [ "$?" -eq 0 ]
  rm -v $curl_params
  [ "$?" -eq 0 ]
  psql -U postgres -c "drop database g1;"
  [ "$?" -eq 0 ]
  psql -U postgres -c "drop database s1;"
  [ "$?" -eq 0 ]
}

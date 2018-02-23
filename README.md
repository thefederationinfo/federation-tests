# Federation Tests

This repository is about automating federation tests in the network itself (see [the-federation.info](http://the-federation.info/)).

# Layout

Every image has to accept and use following parameters:

    PORT=\d+
    DATABASE=[\w\d]+

`DATABASE` represents the name of the docker container and the database name.  
`PORT` should be an unused port (check already existing container). All docker container will be executed with `--net=host` and will share the same network host. Therefore a unique port number is mandatory!

The test helper will call docker like following:

    docker run --name=$1 -e DATABASE=$1 -e PORT=$2 -p $2:$2 --net=host -d thefederation/$3
    
Starting a GangGo and Diaspora application server is then possible by writing tests like this:

```
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
```

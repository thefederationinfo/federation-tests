# Federation Tests [![](https://travis-ci.org/thefederationinfo/federation-tests.svg?branch=master)](https://travis-ci.org/thefederationinfo/federation-tests)

This repository is about automating federation tests in the network itself!

* [the-federation.info](https://the-federation.info/)
* [testsuite.the-federation.info](https://testsuite.the-federation.info/)

## Projects

Following projects are using the testsuite:

* [GangGo](https://github.com/ganggo)
* [Socialhome](https://github.com/jaywink/socialhome)

## Add your project

Clone this repository and create a new directory:

    git clone https://github.com/thefederationinfo/federation-tests.git
    cd federation-tests && mkdir <project-name>
 
In this folder you have to put everything which is required for building an automated docker image.
Starting with a `Dockerfile` and a start-up script e.g. `start.sh`

The start-up script is required so that we can do some configuration magic at boot time.

Following environment variables will be available while tests are running:

    $DATABASE (on every run)
    $PORT     (on every run)
    $PRREPO   (only on pull_requests from a user)
    $PRSHA    (only on pull_requests from a user)

This information we can use in our start-up script mentioned above.  
For example if `PRREPO` and `PRSHA` is set we probably want to checkout the source code of the pull request first.

Checkout for reference the start-up script of the ganggo image:

```
#!/bin/bash

repo=$GOPATH/src/github.com/ganggo/ganggo
if [ ! -z ${PRSHA} ]; then
  if [ "$(basename $PRREPO)" == "ganggo.git" ]; then
    cd $repo && git stash \
      && git remote add custom $PRREPO \
      && git fetch custom \
      && git checkout $PRSHA \
      && git log -1 || {
        echo "Cannot find $PRREPO $PRSHA"
        exit 1
      }
  fi
  if [ "$(basename $PRREPO)" == "federation.git" ]; then
    wd=$repo/vendor/github.com/ganggo/federation
    rm -r $wd && git clone $PRREPO $wd \
      && cd $wd \
      && git checkout $PRSHA \
      && git log -1 || {
        echo "Cannot checkout $PRREPO $PRSHA"
        exit 1
      }
  fi
fi

sed -i "s/NAME/$DATABASE/g" $repo/conf/app.conf \
  && sed -i "s/PORT/$PORT/g" $repo/conf/app.conf \
  && revel run github.com/ganggo/ganggo
```

In the above example support for `github.com/ganggo/federation` and `github.com/ganggo/ganggo` was added.  
If a user triggers a build with the following parameters:

    PRREPO=https://github.com/someuser/federation.git
    PRSHA=1234567890

The testsuite will replace the offical with the user repository and checkout the mentioned commit.

If you did all that `\m/` Create a pull-request with your changes in this repository and as soon as we merged it.  
You can add your repository [here](https://testsuite.the-federation.info/auth)!

Now the testing can begin :)

# Development

## Dependencies

In case you want to test specific parts locally you need `postgresql`, `docker` and `redis`.
Make sure they are up and running:

    sudo systemctl start redis.service postgresql.service docker.service

Then you can install the testsuite dependencies:

* github.com/stedolan/jq
* github.com/sstephenson/bats

Simply run the install script or do it manually:

    bash scripts/install.sh

## Run tests

After installing all required dependencies you can start single tests via:

    # bats <test-file> e.g.:
    bats ganggo-ganggo.tx-rx.bats

Or run all tests with a single command:

    bats .

## Run images

Sometimes doing tests manually helps developing a new feature. You can run single docker images by using the helper script.
Setup the environment by executing following command once:

    BATS_TEST_FILENAME=local . ./test_helper.bash

Then starting can be done by executing:

    # start_app <database-name> <port> "testing_<project>"$(latest_tag <project>)
    # for starting a ganggo image that could look like following:
    start_app g1 9000 "testing_ganggo"$(latest_tag "ganggo")

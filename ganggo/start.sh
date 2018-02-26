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

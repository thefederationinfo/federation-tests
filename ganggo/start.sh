#!/bin/bash

repo=$GOPATH/src/github.com/ganggo/ganggo
if [ "$PROJECT" == "ganggo" ]; then
  if [ "$(basename $PRREPO)" == "federation.git" ]; then
    repo=$repo/vendor/github.com/ganggo/federation
  fi

  cd $repo && git stash \
    && git remote add custom $PRREPO \
    && git fetch custom \
    && git merge $PRSHA \
    && git log -1 || {
      echo "Cannot find $PRREPO $PRSHA"
      exit 1
    }
fi

sed -i "s/NAME/$DATABASE/g" $repo/conf/app.conf \
  && sed -i "s/PORT/$PORT/g" $repo/conf/app.conf \
  && revel run github.com/ganggo/ganggo

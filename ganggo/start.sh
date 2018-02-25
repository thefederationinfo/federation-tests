#!/bin/bash

repo=$GOPATH/src/github.com/ganggo/ganggo
if [ ! -z ${PRSHA} ]; then
  user=$(echo $PRREPO |cut -d'/' -f1)
  userrepo=$(echo $PRREPO |cut -d'/' -f2)
  wd=$repo
  if [ "$userrepo" -eq "federation" ]; then
    wd=$repo/vendor/github.com/ganggo/federation
  fi
  cd $wd \
    && git remote add custom https://github.com/$user/$userrepo.git \
    && git fetch custom \
    && git checkout $PRSHA \
    && git log -1
fi

sed -i "s/NAME/$DATABASE/g" $repo/conf/app.conf \
  && sed -i "s/PORT/$PORT/g" $repo/conf/app.conf \
  && revel run github.com/ganggo/ganggo

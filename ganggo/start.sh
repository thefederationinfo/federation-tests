#!/bin/bash

repo=$GOPATH/src/github.com/ganggo/ganggo
# parse and replace configuration values
sed -i "s/NAME/$DATABASE/g" $repo/conf/app.conf \
  && sed -i "s/PORT/$PORT/g" $repo/conf/app.conf

if [ "$PROJECT" == "ganggo" ]; then
  if [ "$(basename $PRREPO)" == "federation.git" ]; then
    repo=$repo/vendor/github.com/ganggo/federation
    # go-dep prunes git-directory from vendor folder
    rm -r $repo && git clone \
      https://github.com/ganggo/federation.git $repo
  fi

  cd $repo && git stash \
    && git remote add custom $PRREPO \
    && git fetch custom \
    && git merge $PRSHA \
    && git log -1 || {
      echo "Cannot find $PRREPO $PRSHA"
      exit 1
    }

  # install new dependencies
  # and compile assets
  make install precompile
fi

# start the application server
revel run github.com/ganggo/ganggo

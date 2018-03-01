#!/bin/bash

WEBPACK_PORT=$(($PORT+100))

# XXX workaround for ruby goldfinger gem
# adds the ability to search profiles via http
# (see https://github.com/tootsuite/goldfinger/pull/2)
sed -i 's/https/http/' \
  /usr/local/bundle/gems/goldfinger-*/lib/goldfinger/client.rb

sed -i "s/DATABASE_NAME/$DATABASE/" /mastodon/.env
sed -i "s/port: 3035/port: $WEBPACK_PORT/" config/webpacker.yml
./bin/webpack-dev-server --port $WEBPACK_PORT &

bundle exec rails db:setup
bundle exec rails server -p $PORT

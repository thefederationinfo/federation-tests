#!/bin/bash

WEBPACK_PORT=$(($PORT+100))

sed -i "s/APP_PORT/$PORT/" /mastodon/.env
sed -i "s/DATABASE_NAME/$DATABASE/" /mastodon/.env
sed -i "s/port: 3035/port: $WEBPACK_PORT/" config/webpacker.yml
./bin/webpack-dev-server --port $WEBPACK_PORT &

bundle exec rails db:setup
bundle exec rails server -p $PORT

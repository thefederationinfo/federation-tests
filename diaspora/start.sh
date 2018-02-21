#!/bin/bash

redis-server &

cd /diaspora \
  && sed -i "s/NAME/$DATABASE/g" schema.sql \
  && sed -i "s/PORT/$PORT/g" schema.sql \
  && sed -i "s/database: diaspora_production/database: $DATABASE/" config/database.yml \
  && sed -i "s/url: \".*\"/url: \"http:\/\/localhost:$PORT\/\"/" config/diaspora.yml \
  && bundle exec rails db:drop db:create db:migrate \
  && psql -U postgres -h localhost -p 5432 -d $DATABASE < schema.sql \
  && ./script/server

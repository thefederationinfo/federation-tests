#!/bin/bash

cd /diaspora \
  && sed -i "s/USERNAME/$DATABASE/g" schema.sql \
  && sed -i "s/GUID/$DATABASE/" schema.sql \
  && sed -i "s/PORT/$PORT/g" schema.sql \
  && sed -i "s/database: diaspora_development/database: $DATABASE/" config/database.yml \
  && sed -i "s/url: \".*\"/url: \"http:\/\/localhost:$PORT\/\"/" config/diaspora.yml \
  && bundle exec rails db:migrate \
  && psql -U postgres -h localhost -p 5432 -d $DATABASE < schema.sql \
  && ./script/server

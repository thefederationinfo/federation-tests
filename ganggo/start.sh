#!/bin/bash

cd /ganggo \
  && sed -i "s/NAME/$DATABASE/g" app.conf \
  && sed -i "s/PORT/$PORT/g" app.conf \
  && /ganggo/${BIN} -channel disable -mode dev

#!/bin/bash

# install jq command line json parser
sudo curl -o /usr/local/bin/jq -L \
  https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64

# install bats unit testing in bash
git clone --depth 1 https://github.com/sstephenson/bats.git
cd bats && sudo ./install.sh /usr/local && cd -

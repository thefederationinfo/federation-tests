#!/bin/bash

repo=/socialhome
if [ "$PROJECT" == "socialhome" ]; then
  if [ "$(basename $PRREPO)" == "federation.git" ]; then
    repo=$repo/src/federation
    rm -r $repo && git clone \
      https://github.com/jaywink/federation.git $repo
  fi

  cd $repo && git stash \
    && git remote add custom $PRREPO \
    && git fetch custom \
    && git merge $PRSHA \
    && git log -1 || {
      echo "Cannot find $PRREPO $PRSHA"
      exit 1
    }

  # re-install dependencies
  cd /socialhome \
    && pip-sync dev-requirements.txt \
    && npm install \
    && manage.py migrate \
    && npm run dev
fi

# NOTE workaround for validating localhost domain name
sed -i 's/\\\.//' /socialhome/src/federation/federation/utils/text.py

# NOTE enable key generation in development mode
sed -i 's/SOCIALHOME_GENERATE_USER_RSA_KEYS_ON_SAVE = False/SOCIALHOME_GENERATE_USER_RSA_KEYS_ON_SAVE = True/' /socialhome/config/settings/local.py

# XXX hotfix http fallback support in development mode
# see https://github.com/jaywink/federation/issues/120
sed -i 's/raise_ssl_errors=True/raise_ssl_errors=False/' \
  /socialhome/src/federation/federation/utils/network.py
sed -i 's/return "https/return "http/g' \
  /socialhome/src/federation/federation/utils/diaspora.py

sed -i "s/NAME/$DATABASE/g" /socialhome/.env
sed -i "s/PORT/$PORT/g" /socialhome/.env

cd /socialhome
python manage.py migrate
python manage.py collectstatic
#python manage.py rebuild_index
python manage.py runserver localhost:$PORT &

tail -f /socialhome/socialhome.log

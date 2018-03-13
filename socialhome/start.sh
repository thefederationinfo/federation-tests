#!/bin/bash

if [ "$PROJECT" == "socialhome" ]; then
  # fetch user repo
  cd /socialhome && git stash \
    && git remote add custom $PRREPO \
    && git fetch custom \
    && git checkout $PRSHA \
    && git stash pop \
    && git log -1 || {
      echo "Cannot find $PRREPO $PRSHA"
      exit 1
    }
  # re-install dependencies
  cd /socialhome \
    && pip-sync dev-requirements.txt \
    && manage.py migrate \
    && npm run dev
fi

sed -i "s/NAME/$DATABASE/g" /socialhome/.env
sed -i "s/PORT/$PORT/g" /socialhome/.env

python manage.py migrate
python manage.py collectstatic
#python manage.py rebuild_index
python manage.py runserver localhost:$PORT &

tail -f /socialhome/socialhome.log

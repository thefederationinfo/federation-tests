FROM python:3

RUN apt-get update
RUN apt-get install -y git-core

RUN git clone https://github.com/jaywink/socialhome.git
WORKDIR /socialhome

RUN bash install_ubuntu_dependencies.sh install

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN pip install -U pip setuptools==30.4 pip-tools
RUN pip-sync dev-requirements.txt

RUN npm install
RUN npm install -g bower
RUN bower install --allow-root
RUN npm -g install grunt
RUN npm run build

# XXX workaround for validating localhost domain name
RUN sed -i 's/\\\.//' src/federation/federation/utils/text.py

# XXX hotfix http fallback support in development mode
# see https://github.com/jaywink/federation/issues/120
RUN sed -i 's/raise_ssl_errors=True/raise_ssl_errors=False/' \
  src/federation/federation/utils/network.py
RUN sed -i 's/return "https/return "http/g' \
  src/federation/federation/utils/diaspora.py

COPY .env /socialhome/.env
COPY start.sh /start.sh

CMD [ "/bin/bash", "/start.sh" ]

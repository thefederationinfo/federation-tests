FROM debian:jessie
ENV DEBIAN_FRONTEND noninteractive

ENV VERSION v0-alpha.42
ENV BIN updater.linux-amd64.alpha

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get -y install curl

RUN mkdir /ganggo
WORKDIR /ganggo

RUN curl -LO https://github.com/ganggo/ganggo/releases/download/${VERSION}/${BIN}

RUN apt-get -y purge curl
RUN apt-get clean && apt-get autoclean

RUN chmod +x /ganggo/${BIN}

COPY start.sh /start.sh
COPY app.conf /ganggo/app.conf

CMD ["/bin/bash", "/start.sh"]

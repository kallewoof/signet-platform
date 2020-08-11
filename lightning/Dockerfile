FROM ubuntu:18.04

RUN apt-get update -y && apt install -y wget xz-utils
RUN wget https://github.com/ElementsProject/lightning/releases/download/v0.9.0/clightning-v0.9.0-Ubuntu-18.04.tar.xz
RUN tar -xvf clightning-v0.9.0-Ubuntu-18.04.tar.xz
RUN chmod +x /usr/bin/lightning*

COPY ./config /root/.lightning/config

RUN apt-get update -y \
    && apt-get install -y \
        libsqlite3-dev \
        libpq-dev \
        libsodium-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LIGHTNING_DATA=/root/.lightning

RUN mkdir -p ${LIGHTNING_DATA}

EXPOSE 9735

CMD ["lightningd"]

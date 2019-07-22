# Based on Blockstream's esplora project

FROM debian:stretch-slim

# TODO: weed out unnecessary deps
RUN apt-get -yq update \
    && apt-get -yq install \
        curl \
        git

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get install -yq nodejs

RUN git clone https://github.com/kallewoof/bitcoin-faucet.git /srv/faucet

WORKDIR /srv/faucet

ARG COMMIT=master

RUN git pull \
 && git checkout $COMMIT

SHELL ["/bin/bash", "-c"]

# required to run some scripts as root (needed for docker)
RUN npm config set unsafe-perm true \
    && npm install

# cleanup
RUN apt-get --auto-remove remove -yqq --purge manpages git \
 && apt-get clean \
 && apt-get autoclean \
 && rm -rf /usr/share/doc* /usr/share/man /usr/share/postgresql/*/man /var/lib/apt/lists/* /var/cache/* /tmp/* /root/.cache /*.deb /root/.cargo

ENV FAUCET_NAME="Signet Faucet"

RUN cp config.example.js config.js

EXPOSE 8123

CMD ["./index.js"]

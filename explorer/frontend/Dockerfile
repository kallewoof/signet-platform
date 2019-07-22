FROM debian:stretch@sha256:724b0fbbda7fda6372ffed586670573c59e07a48c86d606bab05db118abe0ef5

RUN apt-get -yqq update \
 && apt-get -yqq upgrade \
 && apt-get -yqq install \
   build-essential \
   curl \
   git \
   libcairo2-dev \
   libgif-dev \
   libjpeg-dev \
   libnginx-mod-http-lua \
   libpixman-1-dev \
   nginx \
   pkg-config \
   procps \
   python \
   runit \
   socat \
   tor

SHELL ["/bin/bash", "-c"]

ENV NODE_VERSION 8.11.4

RUN git clone --quiet --depth 1 --single-branch --branch v0.33.11 https://github.com/creationix/nvm.git /root/.nvm \
 && rm -rf /root/.nvm/.git \
 && source /root/.nvm/nvm.sh \
 && nvm install $NODE_VERSION \
 && nvm alias default $NODE_VERSION \
 && nvm use default

ENV NODE_PATH /root/.nvm/v$NODE_VERSION/lib/node_modules
ENV PATH      /root/.nvm/versions/node/v$NODE_VERSION/bin:$PATH

RUN mkdir -p /srv/explorer/static

RUN git clone https://github.com/kallewoof/esplora.git --branch=2019-07-signet /srv/explorer/source

ARG FOOT_HTML

WORKDIR /srv/explorer/source

RUN npm config set unsafe-perm true \
 && npm install && (cd prerender-server && npm run dist) \
 && DEST=/srv/explorer/static/bitcoin-mainnet \
    npm run dist -- bitcoin-mainnet \
 && DEST=/srv/explorer/static/bitcoin-testnet \
    npm run dist -- bitcoin-testnet \
 && DEST=/srv/explorer/static/bitcoin-signet \
    npm run dist -- bitcoin-signet \
 && DEST=/srv/explorer/static/liquid-mainnet \
    npm run dist -- liquid-mainnet \
 && DEST=/srv/explorer/static/bitcoin-mainnet-blockstream \
    npm run dist -- bitcoin-mainnet blockstream \
 && DEST=/srv/explorer/static/bitcoin-testnet-blockstream \
    npm run dist -- bitcoin-testnet blockstream \
 && DEST=/srv/explorer/static/liquid-mainnet-blockstream \
    npm run dist -- liquid-mainnet blockstream

# configuration
RUN cp /srv/explorer/source/run.sh /srv/explorer/

# cleanup
RUN apt-get --auto-remove remove -yq --purge manpages git \
 && apt-get clean \
 && apt-get autoclean \
 && rm -rf /usr/share/doc* /usr/share/man /usr/share/postgresql/*/man /var/lib/apt/lists/* /var/cache/* /tmp/* /root/.cache /*.deb /root/.cargo

WORKDIR /srv/explorer/source

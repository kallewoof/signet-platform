FROM debian:stretch-slim as builder

RUN apt-get update -y \
    && apt-get install -y \
        automake \
        autotools-dev \
        bsdmainutils \
        build-essential \
        git \
        gosu \
        libboost-chrono-dev \
        libboost-filesystem-dev \
        libboost-system-dev \
        libboost-test-dev \
        libboost-thread-dev \
        libevent-dev \
        libminiupnpc-dev \
        libssl-dev \
        libtool \
        libzmq3-dev \
        pkg-config \
        python3 \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/kallewoof/bitcoin.git --branch signet-0.18 /workspace

WORKDIR /workspace

RUN ./contrib/install_db4.sh `pwd`

RUN ./autogen.sh

ENV BDB_PREFIX='/workspace/db4'

RUN  ./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include" --disable-tests --disable-bench --without-gui --prefix=/workspace/build

RUN V=1 make clean

RUN V=1 make -j4

RUN make install

FROM debian:stretch-slim

RUN apt-get update -y \
    && apt-get install -y \
        curl \
        libboost-chrono1.62.0 \
        libboost-filesystem1.62.0 \
        libboost-system1.62.0 \
        libboost-thread1.62.0 \
        libevent-2.0-5 \
        libevent-pthreads-2.0-5 \
        libminiupnpc10 \
        libssl1.1 \
        libzmq5 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder "/workspace/build/bin" /usr/local/bin

COPY --from=builder /workspace/contrib /workspace/contrib

ENV BITCOIN_VERSION=0.18.0
ENV BITCOIN_DATA=/root/.bitcoin
ENV PATH=/workspace/contrib/signet:$PATH

RUN mkdir -p ${BITCOIN_DATA}

COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 8332 8333 18332 18333 18443 18444 38332 38333

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bitcoind", "-signet"]

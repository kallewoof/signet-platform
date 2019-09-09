#!/bin/bash
# Source: https://github.com/ruimarinho/docker-bitcoin-core/blob/master/0.18/docker-entrypoint.sh

set -e

if [ ! -e "$BITCOIN_DATA/bitcoin.conf" ]; then
    echo "$0: creating $BITCOIN_DATA/bitcoin.conf with signet=1"
    echo -e "signet=1\n[signet]\n$BITCOIN_EXTRA_ARGS" > $BITCOIN_DATA/bitcoin.conf
fi

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for bitcoind"
  set -- bitcoind "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "bitcoind" ]; then
  mkdir -p "$BITCOIN_DATA"
  chmod 700 "$BITCOIN_DATA"

  echo "$0: setting data directory to $BITCOIN_DATA"

  set -- "$@" -datadir="$BITCOIN_DATA"
fi

echo
exec "$@"

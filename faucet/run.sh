#!/bin/bash

# You can optionally build the docker image manually by doing
#
#   docker build -t kallewoof/signet-faucet:0.18 .
#
# or
#
#   ./build.sh
#
# and then call this script. Note that you cannot customize the image name here.
# If you want custom images, instead edit the docker-compose.yml file!

set -e

if [ $# -gt 0 ]; then echo "syntax: $0 takes no arguments; modify docker-compose.yml to your needs"; exit 1; fi

docker-compose up

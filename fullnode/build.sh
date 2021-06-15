#!/bin/bash

# Build the bitcoin full node docker image
# Takes image name as first argument, which defaults to
#
#   kallewoof/bitcoin:0.21

imagename="kallewoof/bitcoin:0.21"

if [ $# -gt 0 ]; then imagename=$1; shift; fi
if [ $# -gt 0 ]; then echo "syntax: $0 [<image name>]"; exit 1; fi

docker build -t $imagename .

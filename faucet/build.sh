#!/bin/bash

# Build the signet faucet docker image
# Takes image name as first argument, which defaults to
#
#   kallewoof/signet-faucet:0.18

imagename="kallewoof/signet-faucet:0.18"

if [ $# -gt 0 ]; then imagename=$1; shift; echo "warning: while you can build a custom image, run.sh will use the default; you must update docker-compose.yml to use $imagename instead of the default kallewoof/signet-faucet:0.18 for this to have any effect"; fi
if [ $# -gt 0 ]; then echo "syntax: $0 [<image name>]"; exit 1; fi

docker build -t $imagename .

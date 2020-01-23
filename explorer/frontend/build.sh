#!/bin/bash

# Build the signet explorer frontend docker image
# Takes image name as first argument, which defaults to
#
#   kallewoof/signet-explorer-frontend:0.18

imagename="kallewoof/signet-explorer-frontend:0.18"

if [ $# -gt 0 ]; then imagename=$1; shift; fi
if [ $# -gt 0 ]; then echo "syntax: $0 [<image name>]"; exit 1; fi

docker build -t $imagename .

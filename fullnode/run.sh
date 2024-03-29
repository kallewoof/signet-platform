#!/bin/bash

# You can optionally build the docker image manually by doing
#
#   docker build -t SOMENAME .
#
# or
#
#   ./build.sh SOMENAME
#
# and then call this script with SOMENAME as the first argument.
#
# SOMENAME defaults to kallewoof/bitcoin:0.21 in both the build.sh and
# run.sh cases.
#
# You can also choose the directory to map the bitcoin data directory to,
# as the second argument. This defaults to
#
#   $HOME/docker-signet

set -e -a

imagename="kallewoof/bitcoin:0.21"
datadirmp=$HOME/docker-signet

if [ $# -gt 0 ]; then imagename=$1; shift; fi
if [ $# -gt 0 ]; then datadirmp=$1; shift; fi
if [ $# -gt 0 ]; then echo "syntax: $0 [<image name> [<datadir>]]"; exit 1; fi

mkdir -p $datadirmp
docker run -p 38333:38333 -v $datadirmp:/root/.bitcoin $imagename

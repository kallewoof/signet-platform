#!/bin/bash

#
#   c-lightning

imagename="c-lightning"

if [ $# -gt 0 ]; then imagename=$1; shift; fi
if [ $# -gt 0 ]; then echo "syntax: $0 [<image name>]"; exit 1; fi

docker build -t $imagename .

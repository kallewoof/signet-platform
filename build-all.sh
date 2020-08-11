#!/bin/bash

set -e

echo "*** FULL NODE ***"

cd fullnode
./build.sh

echo "*** LIGHTNING ***"
cd ../lightning
./build.sh

cd ../..

echo "All done"

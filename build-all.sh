#!/bin/bash

echo "*** FULL NODE ***"

cd fullnode
./build.sh

echo "*** FAUCET ***"
cd ../faucet
./build.sh

echo "*** EXPLORER BACK END ***"
cd ../explorer/backend
./build.sh

echo "*** EXPLORER FRONT END ***"
cd ../frontend
./build.sh

cd ../..

echo "All done"

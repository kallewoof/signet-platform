#!/bin/bash

if [ $# -ne 4 ]; then
    echo "syntax: $0 <docker image> <tag> <github url> <github branch>"
    echo "example: $0 kallewoof/signet 0.18 https://github.com/kallewoof/bitcoin.git signet-0.18"
    echo "This command lets you modify the default signet image and github branch to use when generating docker images."
    exit 1
fi

for i in */docker-compose.yml */*.sh */*/*.sh fullnode/Dockerfile; do
    n=$(basename i)
    sed "s~kallewoof/signet:0.18~$1:$2~g" $i > new1.$n
    if [ $? -ne 0 ]; then echo 'failed to patch $i'; exit 1; fi
    sed "s~https://github.com/kallewoof/bitcoin.git~$3~g" new1.$n > new2.$n
    if [ $? -ne 0 ]; then echo 'failed to patch $i'; exit 1; fi
    sed "s~--branch signet-0.18~--branch $4~g" new2.$n > new3.$n
    if [ $? -ne 0 ]; then echo 'failed to patch $i'; exit 1; fi
    sed "s~kallewoof/signet-faucet:0.18~$1-faucet:$2~g" new3.$n > new4.$n
    if [ $? -ne 0 ]; then echo 'failed to patch $i'; exit 1; fi
    sed "s~kallewoof/signet-explorer-backend:0.18~$1-explorer-backend:$2~g" new4.$n > new5.$n
    if [ $? -ne 0 ]; then echo 'failed to patch $i'; exit 1; fi
    sed "s~kallewoof/signet-explorer-frontend:0.18~$1-explorer-frontend:$2~g" new5.$n > new6.$n
    if [ $? -ne 0 ]; then echo 'failed to patch $i'; exit 1; fi
    cat new6.$n > $i
    rm new[123456].$n
done

#!/bin/bash

if [ $# -ne 3 ]; then
    echo "syntax: $0 <docker image> <github url> <github branch>"
    echo "example: $0 kallewoof/signet:0.18 https://github.com/kallewoof/bitcoin.git signet-0.18"
    echo "This command lets you modify the default signet image and github branch to use when generating docker images."
    exit 1
fi

for i in */docker-compose.yml */*.sh fullnode/Dockerfile; do
    n=$(basename i)
    sed "s~kallewoof/signet:0.18~$1~g" $i > new1.$n
    if [ $? -ne 0 ]; then echo 'failed to patch $i'; exit 1; fi
    sed "s~https://github.com/kallewoof/bitcoin.git~$2~g" new1.$n > new2.$n
    if [ $? -ne 0 ]; then echo 'failed to patch $i'; exit 1; fi
    sed "s~--branch signet-0.18~--branch $3~g" new2.$n > new3.$n
    mv new3.$n $i
    rm new[123].$n
done

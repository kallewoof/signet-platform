#!/bin/bash

if [ $# -ne 2 ]; then
    echo "syntax: $0 <docker user> <docker image>"
    echo "example: $0 kallewoof signet:0.18"
    echo "This command lets you modify the default signet image to use."
    exit 1
fi

for i in */docker-compose.yml */*.sh; do
    n=$(basename i)
    sed "s/kallewoof\/signet:0.18/$1\/$2/g" $i > new.$n
    if [ $? -ne 0 ]; then echo 'failed to patch $i'; exit 1; fi
    mv new.$n $i
done

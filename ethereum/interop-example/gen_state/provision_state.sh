#!/bin/bash

[ -z $1 ] && echo "no count argument given" && exit
[ -z $2 ] && echo "no genesis-time argument given" && exit

echo "building docker image"
docker build . -t zcli &>/dev/null

echo "generating state -- count:"$1"; out:./state.ssz; genesis-time:"$2

{
    docker container run -id --name zcli zcli &>/dev/null
    docker exec zcli zcli genesis mock --count $1 --keys ./keygen_10000_validators.yaml --out ./state.ssz --genesis-time $2 &>/dev/null
} || {

    docker exec zcli zcli genesis mock --count $1 --keys ./keygen_10000_validators.yaml --out ./state.ssz --genesis-time $2 &>/dev/null
}

docker container cp zcli:/zcli/state.ssz ./

echo "state built"

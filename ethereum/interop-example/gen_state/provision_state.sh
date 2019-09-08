#!/bin/bash

docker build . -t zcli &>/dev/null
echo "building docker image"

{
    docker container run -id --name zcli zcli &>/dev/null
    docker exec zcli zcli genesis mock --count 60 --keys ./keygen_10000_validators.yaml --out ./state.ssz
} || {

    docker exec zcli zcli genesis mock --count 60 --keys ./keygen_10000_validators.yaml --out ./state.ssz
}

docker container cp zcli:/zcli/state.ssz ./

echo "state built"

#!/bin/bash
  
[ -z $1 ] && echo "no count argument given" && exit
[ -z $2 ] && echo "no genesis-time argument given" && exit
[ -z $3 ] && echo "no shards argument given" && exit

TIME=$(date +%s)
TIME=$(($TIME+$2))

echo "building docker image"
sudo docker build . -t zcli &>/dev/null

echo "generating state -- count:"$1"; out:./state.ssz; genesis-time:"$TIME"; shards:"$3

SHARDS=""
for (( i=0; i<$3; i++ ))
do
    SHARDS+=$1
    SHARDS+=" "
done

rm key_batch*
rm state.ssz

{
    sudo docker container run -id --name zcli zcli &>/dev/null
    sudo docker exec zcli bash -c "rm ./key_batch* state.ssz"
    sudo docker exec zcli zcli keys shard --keys keygen_10000_validators.yaml $SHARDS
    sudo docker exec zcli zcli genesis mock --count $(($1*$3)) --keys ./keygen_10000_validators.yaml --out ./state.ssz --genesis-time $TIME &>/dev/null
} || {
    sudo docker exec zcli bash -c "rm ./key_batch* state.ssz"
    sudo docker exec zcli zcli keys shard --keys keygen_10000_validators.yaml $SHARDS
    sudo docker exec zcli zcli genesis mock --count $(($1*$3)) --keys ./keygen_10000_validators.yaml --out ./state.ssz --genesis-time $TIME &>/dev/null
}

sudo docker container cp zcli:/zcli/state.ssz ./
for (( i=0 ;i<$3 ;i++ ))
do
    sudo docker container cp zcli:/zcli/key_batch_$i.yaml ./
done

echo "state built"

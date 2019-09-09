#!/bin/bash
GENESIS_TIME=$1
VALIDATORS_COUNT=$2
IMAGES=(${@:3})
NUMBER_OF_NODES=${#IMAGES[@]}
./provision_state.sh $VALIDATORS_COUNT $GENESIS_TIME $NUMBER_OF_NODES

IMAGES_STR="\""
KEYS=""
ARGS=""

for (( i=0; i<$NUMBER_OF_NODES; i++ ))
do
   ARGS+='{"validatorKeys":"/launch/keys.yaml","genesisState":"/launch/state.ssz"},'
   KEYS+="{\"./state.ssz\":\"/launch/state.ssz\",\"./keys_batch_$i.yaml\":\"/launch/keys.yaml\"},"
   IMAGES_STR+="${IMAGES[$i]}"
   IMAGES_STR+='","'
done

JSON='{
  "blockchain":"generic",
  "nodes":'
JSON+=${#IMAGES[@]}
JSON+=',"images":['
JSON+=${IMAGES_STR::-3}
JSON+='"],"params": {"args": ['
JSON+=${ARGS::-1}
JSON+='],"files": ['
JSON+=${KEYS::-1}
JSON+='],"libp2p": "true"}}'
echo $JSON
#curl -X POST http://localhost:8000/testnets/ -d $JSON -H "Authorization: Bearer $WB_JWT" -H "Content-Type: application/json"

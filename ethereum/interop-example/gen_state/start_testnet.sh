#!/bin/bash
GENESIS_TIME=$1
VALIDATORS_COUNT=$2
IMAGES=(${@:3})
NUMBER_OF_NODES=${#IMAGES[@]}
./provision_state.sh $VALIDATORS_COUNT*$NUMBER_OF_NODES $GENESIS_TIME

IMAGES_STR="\""
KEYS=""
ARGS=""

echo $IMAGES
echo ${#IMAGES[@]}
echo $NUMBER_OF_NODES

for (( i=0; i<$NUMBER_OF_NODES; i++ ))
do
   ARGS+='{"validatorKeys":"/launch/keys.yaml","genesisState":"/launch/state.ssz"},'
   KEYS+="{\"./state.ssz\":\"/launch/state.ssz\",\"./keys$i.yaml\":\"/launch/keys.yaml\"},"
   IMAGES_STR+="${IMAGES[$i]}"
   IMAGES_STR+='","'
done
echo $IMAGES_STR

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
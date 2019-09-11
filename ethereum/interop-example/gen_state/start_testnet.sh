#!/bin/bash
GENESIS_TIME=$1
VALIDATORS_COUNT=$2
IMAGES=(${@:3})
NUMBER_OF_NODES=${#IMAGES[@]}
./provision_state.sh $VALIDATORS_COUNT $GENESIS_TIME $NUMBER_OF_NODES

IMAGES_STR="\""
KEYS=""
ARGS=""
LAUNCH_SCRIPTS=""

cp state.ssz /tmp/
cp key_batch_* /tmp/

for (( i=0; i<$NUMBER_OF_NODES; i++ ))
do
   ARGS+='{"validator-keys":"/launch/keys.yaml","gen-state":"/launch/state.ssz"},'
   KEYS+="{\"/tmp/state.ssz\":\"/launch/state.ssz\",\"/tmp/key_batch_$i.yaml\":\"/launch/keys.yaml\"},"
   LAUNCH_SCRIPTS+='"/launch/start.sh",'
   IMAGES_STR+="${IMAGES[$i]}"
   IMAGES_STR+='","'
done

JSON='{
  "blockchain":"generic",
  "servers":[1],
  "nodes":'
JSON+=${#IMAGES[@]}
JSON+=',"images":['
JSON+=${IMAGES_STR::-3}
JSON+='"],"params": {"args": ['
JSON+=${ARGS::-1}
JSON+='],"files": ['
JSON+=${KEYS::-1}
JSON+='],"launch-script": ['
JSON+=${LAUNCH_SCRIPTS::-1}
JSON+='],"libp2p": "true","network-topology":"all"}}'
echo $JSON
CMD="curl -X POST http://localhost:8000/testnets/ -d '"
CMD+=$JSON
CMD+="' -H \"Authorization: Bearer "
CMD+=$WB_JWT
CMD+='" -H "Content-Type: application/json"'
echo $CMD
bash -c "$CMD"


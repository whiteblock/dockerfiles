#!/bin/bash

IDENTITY=""
PEERS=""
NUM_VALIDATORS="3"
GEN_STATE=""
PORT="8000"

usage() {
    echo "--identity=<identity>"
    echo "--peer=<peer>"
    echo "--num-validators=<number>"
    echo "--gen-state=<file path>"
    port "--port=<port number>"
}

while [ "$1" != "" ];
do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | sed 's/^[^=]*=//g'`

    case $PARAM in
        --identity)
            IDENTITY=$VALUE
            ;;
        --peers)
            PEERS=$VALUE
            ;;
        --num-validators)
            NUM_VALIDATORS=$VALUE
            ;;
        --gen-state)
            GEN_STATE=$VALUE
            ;;
        --port)
            PORT=$VALUE
            ;;
        --help)
            usage
            exit
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done

echo $PORT

# 4 params for start.sh:
    # identity (p2p-priv-key)
    # peers
    # numValidators,
    # genesis state (16KB -- pass a reference to a file in the docker container)

# should start the //beacon-chain and //validators
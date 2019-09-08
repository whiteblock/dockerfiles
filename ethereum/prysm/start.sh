#!/bin/bash

IDENTITY=""
PEERS=""
VALIDATOR_KEYS=""
GEN_STATE=""
PORT="8000"

usage() {
    echo "--identity=<hex prepresentation of the priv key for libp2p>"
    echo "--peer=<peer>"
    echo "--validator-keys=<path to /launch/keys.yaml>"
    echo "--gen-state=<path to /launch/state.ssz>"
    echo "--port=<port>"
}

while [ "$1" != "" ];
do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | sed 's/^[^=]*=//g'`

    case $PARAM in
        --identity)
            IDENTITY=$VALUE
            ;;
        --peer)
            PEERS+=" $VALUE"
            ;;
        --validator-keys)
            VALIDATOR_KEYS=$VALUE
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

echo $VALIDATOR_KEYS

# 5 params for start.sh:
    # identity (p2p-priv-key)
    # peers
    # validator keys,
    # genesis state (16KB -- pass a reference to a file in the docker container)
    # port

#!/bin/bash

# Flags
IDENTITY=""
PEERS=""
YAML_KEY_FILE=""
GEN_STATE=""
PORT="8000"

# Constants
BEACON_LOG_FILE="/tmp/beacon.log"
VALIDATOR_LOG_FILE="/tmp/validator.log"

usage() {
    echo "--identity=<hex prepresentation of the priv key for libp2p>"
    echo "--peers=<peer>"
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
        --peers)
            PEERS+=",$VALUE"
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


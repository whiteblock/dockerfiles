# Provision Script
## OverView
The `provision_state.sh` script will generate an encoded state using the ZCLI tool[[1]](https://github.com/protolambda/zcli). 

You will need to pass `count` as the first argument, which will be used as the number of validators for the initial genesis state. The validator priv/pub keys will be pulled from a pregenerated list[[2]](https://raw.githubusercontent.com/ethereum/eth2.0-pm/master/interop/mocked_start/keygen_10000_validators.yaml). The second argument is the `genesis-time`, which will be used to determine how much time in the future the genesis event will occur. 

The script will do the following things:
1. build an image from the dockerfile provided in this directory 
2. create a container from the built image
3. run the `zcli` tooling to generate an ssz encoded genesis state
4. copies the state from the container to the host machine in the current working directory

This generated state will then be used to copy over to any existing clients. The clients will then be able to coordinate and start the network and test for interoperability.

#### Example:
`./provision_state 60 300`

 

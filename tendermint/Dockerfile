FROM golang:1.11.5-stretch 

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install software-properties-common apt-utils ca-certificates \
    curl git git-extras vim inetutils-tools wget libssl-dev iperf3 \
    openssh-server iputils-ping 



RUN mkdir -p /go/src/github.com/tendermint/tendermint && \
    cd /go/src/github.com/tendermint/tendermint && \
    git clone https://github.com/tendermint/tendermint . && \
    git checkout develop && \
    make get_tools && \
    make get_vendor_deps && \
    make install && \
    cd - && \
    rm -rf /go/src/github.com/tendermint/tendermint


EXPOSE 26656
EXPOSE 26657

ENTRYPOINT ["/bin/bash"]
FROM golang:1.11.5-stretch as built

RUN apt-get -y update
RUN apt-get -y install git git-extras

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

FROM ubuntu:latest as final

RUN apt-get -y update
RUN apt-get -y install software-properties-common apt-utils ca-certificates \
    curl git git-extras vim inetutils-tools wget iperf3 openssh-server iputils-ping 

COPY --from=built /go/bin/tendermint /usr/bin/

ENTRYPOINT ["/bin/bash"]
FROM ubuntu:18.04 as built

RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils expect git git-extras software-properties-common \
    inetutils-tools wget ca-certificates curl build-essential libssl-dev golang-go make
# builds out geth
RUN git clone https://github.com/zscole/go-ethereum &&\
        cd /go-ethereum &&\
        make all


FROM ubuntu:18.04 as final

COPY --from=built /go-ethereum/build/bin /usr/local/bin

RUN apt-get update && apt-get install -f -y npm nodejs git
# sets up eth net intelligence api & dependencies
RUN git clone https://bitbucket.org/whiteblockio/eth-net-intelligence-api.git
WORKDIR /eth-net-intelligence-api


RUN apt-get install -y iperf3 openssh-server iputils-ping vim tmux software-properties-common && apt-get clean

RUN npm install && npm install -g pm2

RUN add-apt-repository ppa:ethereum/ethereum && \
    apt-get update && \
    apt-get install -y solc

RUN ln -s /go-ethereum/build/bin/geth /usr/bin/geth

WORKDIR /
#ENV PATH /go-ethereum/build/bin:${PATH}

ENTRYPOINT ["/bin/bash"]

FROM ubuntu:latest 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y apt-utils iputils-ping expect git git-extras \
    software-properties-common tmux vim inetutils-tools wget ca-certificates \
    curl build-essential libssl-dev iperf3 openssh-server

RUN wget https://github.com/eosio/eos/releases/download/v1.5.3/eosio_1.5.3-1-ubuntu-18.04_amd64.deb &&\
    apt install -y ./eosio_1.5.3-1-ubuntu-18.04_amd64.deb

RUN git clone https://github.com/EOSIO/eos.git


RUN wget https://github.com/eosio/eosio.cdt/releases/download/v1.4.1/eosio.cdt-1.4.1.x86_64.deb &&\
    apt install -y ./eosio.cdt-1.4.1.x86_64.deb

WORKDIR /opt/

RUN git clone https://github.com/EOSIO/eosio.contracts.git

WORKDIR /opt/eosio.contracts/eosio.token/
RUN eosio-cpp -I include -o eosio.token.wasm src/eosio.token.cpp --abigen

WORKDIR /opt/eosio.contracts/eosio.bios/
RUN eosio-cpp -I include -o eosio.bios.wasm src/eosio.bios.cpp --abigen

WORKDIR /opt/eosio.contracts/eosio.system/
RUN eosio-cpp -I include -I ../eosio.token/include -o eosio.system.wasm src/eosio.system.cpp --abigen

WORKDIR /opt/eosio.contracts/eosio.msig/
RUN eosio-cpp -I include -o eosio.msig.wasm src/eosio.msig.cpp --abigen

WORKDIR /opt/eosio.contracts/eosio.wrap
RUN eosio-cpp -I include -o eosio.wrap.wasm src/eosio.wrap.cpp --abigen

WORKDIR /
RUN mkdir -p /opt/eosio &&\
    mv /opt/eosio.contracts/ /opt/eosio/contracts


ENTRYPOINT ["/bin/bash"]

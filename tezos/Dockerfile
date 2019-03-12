FROM ubuntu:18.04

RUN apt-get update && apt-get install -y iputils-ping openssh-server iperf3 vim 
RUN apt-get install -y git ocaml build-essential 

RUN git clone https://gitlab.com/tezos/tezos

RUN apt-get install -y wget 
RUN wget https://github.com/ocaml/opam/releases/download/2.0.3/opam-2.0.3-x86_64-linux &&\
    mv opam-2.0.3-x86_64-linux /usr/local/bin/opam &&\
    chmod +x /usr/local/bin/opam

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y bubblewrap zip m4

RUN opam init --disable-sandboxing --reinit

WORKDIR /tezos

RUN make
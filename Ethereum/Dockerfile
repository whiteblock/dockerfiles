FROM ubuntu:latest

ARG b=master

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\ 
	apt-get install -y apt-utils iputils-ping expect npm git git-extras software-properties-common tmux

RUN add-apt-repository -y ppa:ethereum/ethereum &&\ 
	apt update &&\ 
	apt-get install -y ethereum

RUN git clone -b $b https://bitbucket.org/whiteblockio/eth-net-intelligence-api.git &&\
	npm install pm2 --global &&\
	cd /eth-net-intelligence-api &&\
	npm install 

EXPOSE 30303 8545 8546 30301 30301/udp

ENTRYPOINT ["/bin/bash"]

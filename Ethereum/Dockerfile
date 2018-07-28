FROM ubuntu:latest
LABEL maintainer="zak@whiteblock.io"

RUN apt update && apt install -y apt-utils tzdata &&\
	apt install -y expect npm git git-extras software-properties-common tmux
#ethereum built in another layer
RUN add-apt-repository -y ppa:ethereum/ethereum && apt update && apt install -y ethereum

RUN git clone https://bitbucket.org/whiteblockio/eth-net-intelligence-api.git &&\
	npm install pm2 --global &&\
	cd /eth-net-intelligence-api &&\
	npm install

RUN apt install -y iputils-ping 
EXPOSE 30303 8545 30301 30301/udp
ENTRYPOINT ["/bin/bash"]

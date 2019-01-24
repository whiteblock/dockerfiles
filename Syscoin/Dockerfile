FROM ubuntu:latest
LABEL maintainer="zak@whiteblock.io"

RUN apt update && apt install -y apt-utils tzdata && apt install -y expect git git-extras software-properties-common tmux

RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libminiupnpc-dev &&\
	apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libboost-graph-dev libboost-regex-dev &&\
	add-apt-repository -y ppa:bitcoin/bitcoin && apt update &&\
	apt-get install -y libdb4.8-dev libdb4.8++-dev && \
	apt-get install -y iputils-ping openssh-server

RUN apt-get install -y net-tools iproute2 vim g++-8 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

RUN git clone https://github.com/sidhujag/temp &&\
	cd temp &&\
	./autogen.sh &&\
	./configure --enable-tests &&\
	make -j32 &&\ 
	make install

ENTRYPOINT ["/bin/bash"]


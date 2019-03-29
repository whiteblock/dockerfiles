FROM ubuntu:latest as built
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
	make -j $(nproc) &&\
	make install

FROM ubuntu:latest as final

COPY --from=built /usr/local/bin/syscoind /usr/local/bin/syscoind
COPY --from=built /usr/lib/x86_64-linux-gnu/libboost_system.so.1.65.1 /usr/lib/x86_64-linux-gnu/libboost_system.so.1.65.1
COPY --from=built /usr/lib/x86_64-linux-gnu/libboost_filesystem.so.1.65.1 /usr/lib/x86_64-linux-gnu/libboost_filesystem.so.1.65.1
COPY --from=built /usr/lib/x86_64-linux-gnu/libboost_thread.so.1.65.1 /usr/lib/x86_64-linux-gnu/libboost_thread.so.1.65.1
COPY --from=built /usr/lib/x86_64-linux-gnu/libboost_chrono.so.1.65.1 /usr/lib/x86_64-linux-gnu/libboost_chrono.so.1.65.1
COPY --from=built /usr/lib/libdb_cxx-4.8.so /usr/lib/libdb_cxx-4.8.so
COPY --from=built /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1
COPY --from=built /usr/lib/x86_64-linux-gnu/libminiupnpc.so.10 /usr/lib/x86_64-linux-gnu/libminiupnpc.so.10
COPY --from=built /usr/lib/x86_64-linux-gnu/libevent_pthreads-2.1.so.6 /usr/lib/x86_64-linux-gnu/libevent_pthreads-2.1.so.6
COPY --from=built /usr/lib/x86_64-linux-gnu/libevent-2.1.so.6 /usr/lib/x86_64-linux-gnu/libevent-2.1.so.6
COPY --from=built /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so.6
COPY --from=built /lib/x86_64-linux-gnu/libm.so.6 /lib/x86_64-linux-gnu/libm.so.6
COPY --from=built /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcc_s.so.1
COPY --from=built /lib/x86_64-linux-gnu/libpthread.so.0 /lib/x86_64-linux-gnu/libpthread.so.0
COPY --from=built /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libc.so.6
COPY --from=built /lib/x86_64-linux-gnu/librt.so.1 /lib/x86_64-linux-gnu/librt.so.1
COPY --from=built /lib/x86_64-linux-gnu/libdl.so.2 /lib/x86_64-linux-gnu/libdl.so.2
COPY --from=built /lib64/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2

RUN apt-get update && apt-get install -y iputils-ping openssh-server iperf3 vim 

ENTRYPOINT ["/bin/bash"]


FROM rust:1.32.0-stretch as built

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install \
    -y --no-install-recommends \
    apt-utils iputils-ping expect git git-extras yasm curl \
    software-properties-common tmux gcc libudev-dev pkg-config \
    file make g++ \
    wget ca-certificates cmake \
    iperf3 openssh-server telnet iproute2 libssl-dev \
    && apt-get clean  


RUN git clone https://github.com/paritytech/parity-ethereum
WORKDIR /parity-ethereum
RUN git checkout v2.5.0
RUN cargo clean && cargo build --release --features final

#RUN apt-get install -y wget 
#RUN wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.8.23-c9427004.tar.gz &&\
#    tar xzf geth-linux-amd64-1.8.23-c9427004.tar.gz geth-linux-amd64-1.8.23-c9427004/ &&\
#    mv geth-linux-amd64-1.8.23-c9427004/geth /usr/local/bin/


#RUN echo "export PATH=\"/parity-ethereum/target/release:\${PATH}\"" >> /etc/profile
#ENV PATH="/parity-ethereum/target/release:${PATH}"

EXPOSE 8080 8545 8180

FROM ubuntu:18.04 as final

RUN apt-get update && apt-get install -y  vim iperf3 openssh-server telnet iproute2 libssl-dev iputils-ping tmux
COPY --from=built /parity-ethereum/target/release/parity /usr/local/bin/parity
#COPY --from=built /usr/local/bin/geth /usr/local/bin/geth
WORKDIR /

ENTRYPOINT ["/bin/bash"]

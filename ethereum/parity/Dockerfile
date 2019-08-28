FROM rust:1.37.0-stretch as built

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install \
    -y --no-install-recommends \
    apt-utils git git-extras yasm curl \
    software-properties-common gcc libudev-dev pkg-config \
    file make g++ wget ca-certificates cmake libssl-dev \
    && apt-get clean


RUN git clone https://github.com/paritytech/parity-ethereum
WORKDIR /parity-ethereum
RUN git checkout v2.5.6
RUN cargo clean && cargo build --release --features final

#RUN echo "export PATH=\"/parity-ethereum/target/release:\${PATH}\"" >> /etc/profile
#ENV PATH="/parity-ethereum/target/release:${PATH}"

EXPOSE 8080 8545 8180

FROM ubuntu:18.04 as final

RUN apt-get update && apt-get install -y vim iperf3 openssh-server telnet iproute2 libssl-dev iputils-ping tmux git \
    python3.6 python3-pip python3-dev
RUN apt-get update && apt-get install -f -y npm nodejs

RUN npm install && npm install -g pm2
RUN pip3 install vyper

COPY --from=built /parity-ethereum/target/release/parity /usr/local/bin/parity
WORKDIR /
RUN git clone https://github.com/whiteblock/solc_resources.git

ENTRYPOINT ["/bin/bash"]

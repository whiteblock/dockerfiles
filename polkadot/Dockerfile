FROM phusion/baseimage:0.10.2 as builder
  
RUN apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y cmake pkg-config libssl-dev clang expect git git-extras openssh-server \
        software-properties-common inetutils-tools wget ca-certificates curl build-essential iperf \
        vim make
RUN git clone https://github.com/paritytech/polkadot.git

WORKDIR /polkadot
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
        export PATH="$PATH:$HOME/.cargo/bin" && \
        rustup toolchain install nightly && \
        rustup target add wasm32-unknown-unknown --toolchain nightly && \
        cargo install --git https://github.com/alexcrichton/wasm-gc && \
        rustup default nightly && \
        ./scripts/build.sh && \
        rustup default stable && \
        cargo build --release


FROM ubuntu:18.04 as final

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update &&\
        apt-get install -y apt-utils expect git git-extras software-properties-common \
        inetutils-tools wget ca-certificates curl build-essential libssl-dev golang-go \
        pkg-config zip g++ zlib1g-dev unzip python

COPY --from=builder /polkadot/target/release/polkadot /usr/local/bin

EXPOSE 30333 9933 9944
VOLUME ["/data"]

ENTRYPOINT ["/bin/bash"]

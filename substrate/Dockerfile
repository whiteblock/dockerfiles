FROM phusion/baseimage:0.10.2 

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y cmake pkg-config libssl-dev clang expect git git-extras openssh-server \
	software-properties-common inetutils-tools wget ca-certificates curl build-essential iperf \
	vim make
RUN git clone https://github.com/paritytech/substrate.git

WORKDIR /substrate
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
	export PATH="$PATH:$HOME/.cargo/bin" && \
	rustup toolchain install nightly && \
	rustup target add wasm32-unknown-unknown --toolchain nightly && \
	cargo install --git https://github.com/alexcrichton/wasm-gc && \
	rustup default nightly && \
	./scripts/build.sh && \
	rustup default stable && \
	cargo build --release

ENV PATH ${PATH}:/substrate/target/release/

CMD ["/bin/bash"]

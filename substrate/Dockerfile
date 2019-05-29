FROM phusion/baseimage:0.10.2 as builder

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y cmake pkg-config libssl-dev clang expect git git-extras openssh-server \
	software-properties-common inetutils-tools wget ca-certificates curl build-essential
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

FROM phusion/baseimage:0.10.2
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential \
    tmux wget iperf3 curl apt-utils iputils-ping expect git git-extras \
    software-properties-common 
RUN mv /usr/share/ca* /tmp && \
	rm -rf /usr/share/*  && \
	mv /tmp/ca-certificates /usr/share/ && \
	mkdir -p /root/.local/share/Polkadot && \
	ln -s /root/.local/share/Polkadot /data && \
	useradd -m -u 1000 -U -s /bin/sh -d /substrate substrate

COPY --from=builder /substrate/target/release/substrate /usr/local/bin
RUN ldd /usr/local/bin/substrate && \
	/usr/local/bin/substrate --version
RUN rm -rf /usr/lib/python* && \
	rm -rf /usr/bin /usr/sbin /usr/share/man

CMD ["/bin/bash"]

FROM rust:1.32.0-stretch 

RUN git clone https://github.com/paritytech/shasper.git

RUN rustup update stable &&\
    rustup update nightly &&\
    rustup target add wasm32-unknown-unknown --toolchain nightly &&\
    cargo +nightly install --git https://github.com/alexcrichton/wasm-gc

RUN cd shasper && ./build.sh


ENTRYPOINT ["/bin/bash"]
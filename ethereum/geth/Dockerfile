FROM golang:1.13.4-buster as build

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
    apt-get install -y git ca-certificates curl gcc make
# builds out geth
WORKDIR /src
RUN git clone https://github.com/ethereum/go-ethereum
WORKDIR /src/go-ethereum
RUN make all

FROM ubuntu:18.04 as final
COPY --from=build /src/go-ethereum/build/bin /usr/local/bin

ENTRYPOINT ["/usr/local/bin/geth"]

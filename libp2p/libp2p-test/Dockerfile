FROM golang:1.12.3-stretch

RUN git clone https://github.com/Whiteblock/p2p-tests.git libp2p

WORKDIR /libp2p

RUN go get || true

RUN go build

ENTRYPOINT ["/bin/bash"]
FROM golang:1.12.3-stretch

RUN git clone https://github.com/Whiteblock/p2p-tests.git p2p-tests

WORKDIR /p2p-tests

RUN go get || true

RUN go build

ENTRYPOINT ["/bin/bash"]
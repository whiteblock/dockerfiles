FROM golang:1.12.3-stretch

WORKDIR /

RUN git clone https://github.com/Whiteblock/p2p-tests.git

WORKDIR /p2p-tests

RUN go get || true

RUN go build

ENTRYPOINT ["/bin/bash"]
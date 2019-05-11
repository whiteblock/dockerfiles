FROM golang:1.12.3-stretch

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /

RUN git clone https://github.com/Whiteblock/p2p-tests.git

WORKDIR /p2p-tests

RUN go get || true

RUN go build

RUN apt-get update && apt-get install -y iperf3 openssh-server iputils-ping vim tmux  && apt-get clean

ENTRYPOINT ["/bin/bash"]

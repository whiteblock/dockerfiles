FROM golang:1.12.3-stretch

WORKDIR /

RUN git clone https://github.com/Whiteblock/p2p-tests.git

WORKDIR /p2p-tests

RUN go get || true

RUN go build

RUN apt-get install -y iperf3 openssh-server iputils-ping vim tmux  && apt-get clean

ENTRYPOINT ["/bin/bash"]

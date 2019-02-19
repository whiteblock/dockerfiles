
FROM golang:1.11.5-stretch as built

RUN apt-get -y update
RUN apt-get -y install git git-extras

RUN mkdir -p /go/src/github.com/cosmos/cosmos-sdk && \
    cd /go/src/github.com/cosmos/cosmos-sdk && \
    git clone https://github.com/cosmos/cosmos-sdk.git . && \
    git checkout b9e523212ec47910a00db00be2f1b7935e201ee7 && \
    make tools && \
    make vendor-deps && \
    make build && \
    make install


EXPOSE 26656
EXPOSE 26657

FROM ubuntu:latest as final

RUN apt-get -y update
RUN apt-get -y install software-properties-common apt-utils ca-certificates \
    curl git git-extras vim inetutils-tools wget iperf3 openssh-server iputils-ping 

COPY --from=built /go/bin/gaiad /usr/bin/
COPY --from=built /go/bin/gaiacli /usr/bin/

ENTRYPOINT ["/bin/bash"]
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update &&\
	apt-get install -y apt-utils expect git git-extras software-properties-common \
	inetutils-tools wget ca-certificates curl build-essential libssl-dev golang-go \
  	pkg-config zip g++ zlib1g-dev unzip python openssh-server iperf3 vim tmux

RUN wget https://github.com/bazelbuild/bazel/releases/download/0.25.1/bazel-0.25.1-installer-linux-x86_64.sh
RUN chmod +x bazel-0.25.1-installer-linux-x86_64.sh
RUN ./bazel-0.25.1-installer-linux-x86_64.sh

WORKDIR /
RUN git clone https://github.com/renaynay/prysm.git
WORKDIR /prysm/
RUN git reset --hard HEAD
RUN git checkout cli
RUN git pull

RUN bazel build //beacon-chain

RUN bazel build //validator

ENTRYPOINT ["/bin/bash"]

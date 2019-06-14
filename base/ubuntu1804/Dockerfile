FROM ubuntu:18.04 as built

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y iperf3 openssh-server iputils-ping vim tmux software-properties-common && apt-get clean
RUN apt-get install -y apt-utils expect git git-extras inetutils-tools wget ca-certificates curl \
    build-essential libssl-dev golang-go make && apt-get clean

ENTRYPOINT ["/bin/bash"]
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
    apt-get install -y build-essential \
    openjdk-11-jre tmux wget iperf3 curl apt-utils iputils-ping expect git git-extras \
    software-properties-common openssh-server lsof telnet

COPY gossip.tgz /usr/gossip.tgz
RUN cd /usr \
  && tar xzf gossip.tgz \
  && mv tuweni-gossip-* gossip \
  && rm /usr/gossip.tgz

RUN ln -s /usr/gossip/bin/gossip /usr/bin/gossip

ENTRYPOINT ["/bin/bash"]
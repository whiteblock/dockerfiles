FROM tmio/gossip:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
    apt-get install -y build-essential \
    tmux wget iperf3 curl apt-utils iputils-ping expect git git-extras \
    software-properties-common openssh-server 

RUN ln -s /usr/gossip/bin/gossip /usr/bin/gossip

ENTRYPOINT ["/bin/bash"]
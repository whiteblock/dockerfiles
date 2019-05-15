FROM tmio/gossip:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
    apt-get install -y build-essential \
    tmux wget iperf3 curl apt-utils iputils-ping expect git git-extras \
    software-properties-common openssh-server 

ENTRYPOINT ["/bin/bash"]
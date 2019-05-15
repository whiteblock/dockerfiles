FROM tmio/gossip:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -f &&\
    apt-get install -y build-essential maven libsodium-dev \
    tmux wget iperf3 curl apt-utils iputils-ping expect npm git git-extras \
    software-properties-common openssh-server 

ENTRYPOINT ["/bin/bash"]
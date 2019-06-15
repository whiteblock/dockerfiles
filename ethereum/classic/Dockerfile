FROM whiteblockdev/greggeth:latest

RUN apt-get install -y iperf3 openssh-server iputils-ping vim tmux software-properties-common && apt-get clean
WORKDIR /
ENTRYPOINT ["/bin/bash"]

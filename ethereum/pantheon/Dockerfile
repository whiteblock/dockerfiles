FROM pegasyseng/pantheon:1.2.1

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y build-essential libsodium-dev \
    tmux wget iperf3 curl apt-utils iputils-ping expect git git-extras \
    software-properties-common openssh-server

RUN ln -s /opt/pantheon/bin/pantheon /usr/local/bin/pantheon
WORKDIR /

ENTRYPOINT ["/bin/bash"]
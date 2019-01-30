FROM ubuntu:18.04

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install software-properties-common apt-utils ca-certificates \
    curl git git-extras vim inetutils-tools wget libssl-dev iperf3 \
    openssh-server iputils-ping

RUN mkdir beam

WORKDIR /beam
RUN wget http://builds.beam-mw.com/files/testnet_cpu_mining/2019.01.24/Release/linux/beam-wallet-cli-1.1.4269.tar.gz -O - | tar -xz
RUN wget http://builds.beam-mw.com/files/testnet_cpu_mining/2019.01.24/Release/linux/beam-node-1.1.4269.tar.gz -O - | tar -xz

RUN cp beam-node /bin/

RUN cp beam-wallet /bin/

ENV PATH=/beam:${PATH}

ENTRYPOINT ["/bin/bash"]
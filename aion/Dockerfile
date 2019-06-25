FROM ubuntu:18.04
RUN apt-get update &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils expect git \
    software-properties-common inetutils-tools wget ca-certificates curl \
    libssl-dev make iperf3 iputils-ping tmux build-essential git-extras \
    openssh-server
RUN wget https://github.com/aionnetwork/aion/releases/download/v0.4.0.2/aion-v0.4.0.2.092068b-2019-06-12.tar.bz2
RUN tar -xvf aion-v0.4.0.2.092068b-2019-06-12.tar.bz2
RUN rm -rf aion-v0.4.0.2.092068b-2019-06-12.tar.bz2

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

WORKDIR /aion
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN cd web-console && npm install
CMD ["/bin/bash"]

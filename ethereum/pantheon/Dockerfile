FROM gcr.io/whiteblock/base:ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y build-essential maven libsodium-dev \
    tmux wget iperf3 curl apt-utils iputils-ping expect npm git git-extras \
    software-properties-common openssh-server 

RUN apt-get install -y openjdk-11-jdk-headless openjdk-11-jre-headless

# get pantheon
RUN git clone --recursive https://github.com/PegaSysEng/pantheon.git
WORKDIR /pantheon
RUN ./gradlew build -x test
WORKDIR /pantheon/build/distributions
RUN tar -xzf pantheon-*-SNAPSHOT.tar.gz
#ENV PATH="/pantheon/build/distributions/pantheon-1.0.3-SNAPSHOT/bin:${PATH}"

RUN ln -s /pantheon/build/distributions/pantheon-*-SNAPSHOT/bin/pantheon /usr/local/bin/pantheon
WORKDIR /

ENTRYPOINT ["/bin/bash"]
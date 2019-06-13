FROM ubuntu:18.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential maven libsodium-dev \
    tmux wget iperf3 curl apt-utils iputils-ping expect npm git git-extras \
    software-properties-common openssh-server

# install java
RUN add-apt-repository ppa:openjdk-r/ppa && \
    apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/* 


# get sysethereum-agents
RUN git clone --recursive https://github.com/syscoin/sysethereum-agents.git
WORKDIR sysethereum-agents/
RUN mvn package
WORKDIR /sysethereum-agents/target
RUN ln -s *-jar-with-dependencies.jar syseth.jar

WORKDIR /

ENTRYPOINT [ "java", "-Xmx1g", "-jar", "/sysethereum-agents/target/syseth.jar" ]

FROM ubuntu:18.04 as built


RUN apt-get update && apt-get install -f -y npm nodejs git wget
# sets up eth net intelligence api & dependencies

RUN wget http://whiteblock.io/eth-netstats.tar.gz && tar xf eth-netstats.tar.gz && rm eth-netstats.tar.gz &&\
    cd eth-netstats &&\
    npm install &&\
    npm install -g grunt-cli &&\
    grunt

ENTRYPOINT ["/bin/bash"]
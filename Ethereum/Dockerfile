FROM ubuntu:latest
LABEL maintainer="zak@whiteblock.io"

RUN apt update && apt install -y apt-utils tzdata && apt install -y expect nodejs git git-extras software-properties-common tmux && mkdir /whiteblock
#ethereum built in another layer
RUN add-apt-repository -y ppa:ethereum/ethereum && apt update && apt install -y ethereum


EXPOSE 30303
EXPOSE 8545
EXPOSE 30301
EXPOSE 30301/udp
ENTRYPOINT ["/bin/bash"]

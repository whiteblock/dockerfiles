FROM alpine:3

RUN apk add --no-cache git nodejs npm

RUN git clone https://github.com/cubedro/eth-netstats && \
    cd eth-netstats && \
    npm install && \
    npm install -g grunt-cli && \
    grunt

WORKDIR /eth-netstats

CMD "npm start"
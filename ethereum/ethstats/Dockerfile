FROM alpine:3 as builder

RUN apk add --no-cache git nodejs npm

RUN git clone https://github.com/cubedro/eth-netstats && \
    cd eth-netstats && \
    npm install && \
    npm install -g grunt-cli && \
    grunt

FROM nginx:alpine as final
COPY --from=builder /eth-netstats/dist /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
FROM golang:1.8-alpine as builder

RUN apk add --no-cache git make
RUN git clone https://github.com/inconshreveable/ngrok.git /ngrok
ADD certs/base.pem /ngrok/assets/client/tls/ngrokroot.crt
WORKDIR /ngrok
RUN make release-client

FROM alpine:3.6
RUN mkdir -p /ngrok
RUN mkdir -p /ngrok/bin
RUN mkdir -p /ngrok/config
COPY --from=builder /ngrok/bin/ngrok /ngrok/bin/ngrok

WORKDIR /ngrok/config

ENTRYPOINT [ "/ngrok/bin/ngrok" ]
CMD ["-log", "stdout", "-log-level", "ERROR", "-config", "ngrok.yml", "start-all"]

FROM golang:1.8-alpine as builder

RUN apk add --no-cache git make
RUN git clone https://github.com/inconshreveable/ngrok.git /ngrok
ADD certs/base.pem /ngrok/assets/client/tls/ngrokroot.crt
WORKDIR /ngrok
RUN make release-server

FROM alpine:3.6
RUN mkdir -p /ngrok
RUN mkdir -p /ngrok/bin
RUN mkdir -p /ngrok/certs
COPY --from=builder /ngrok/bin/ngrokd /ngrok/bin/ngrokd

# ENV DOMAIN **None**
WORKDIR /ngrok
ENV CERTS /ngrok/certs

ADD certs/device.key ${CERTS}/
ADD certs/device.crt ${CERTS}/

EXPOSE 30443

ENTRYPOINT [ "/ngrok/bin/ngrokd" ]
CMD [ "-tlsKey=certs/device.key", "-tlsCrt=certs/device.crt", "-domain=mixslice.com", "-tunnelAddr=:30443" ]

#!/bin/sh
set -e

if [ "${DOMAIN}" == "**None**" ]; then
    echo "Please set DOMAIN"
    exit 1
fi

cd ${CERTS}
if [ ! -f "${CERTS}/base.pem" ]; then
    openssl genrsa -out base.key 2048
    openssl req -new -x509 -nodes -key base.key -days 10000 -subj "/CN=${DOMAIN}" -out base.pem
    openssl genrsa -out device.key 2048
    openssl req -new -key device.key -subj "/CN=${DOMAIN}" -out device.csr
    openssl x509 -req -in device.csr -CA base.pem -CAkey base.key -CAcreateserial -days 10000 -out device.crt
fi

echo "keygen ok !"

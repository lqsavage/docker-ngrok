#!/bin/bash
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

ln -s /opt/ngrok/ngrok.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable ngrok
systemctl start ngrok

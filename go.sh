#!/bin/bash
if type go >/dev/null 2>&1; then
    echo "it's installed."
    exit 1
fi
FILENAME=go1.15.7.linux-amd64.tar.gz
cd /tmp/$FILENAME
curl -LO https://golang.org/dl/$FILENAME
sudo tar -C /usr/local -xzf /tmp/$FILENAME
export PATH=$PATH:/usr/local/go/bin
go version

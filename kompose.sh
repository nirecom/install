#!/bin/bash
if type kompose >/dev/null 2>&1; then
    echo "Already installed."
    exit 1
fi

cd
curl -L https://github.com/kubernetes/kompose/releases/download/v1.22.0/kompose-linux-amd64 -o kompose
chmod +x kompose
sudo chown root:root kompose
sudo mv ./kompose /usr/local/bin/kompose


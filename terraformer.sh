#!/bin/bash
if test terraform >/dev/null 2>&1; then
    echo "terraform exists. Skip ..."
else
    # terraformer works with up to this version
    sudo apt install terraform=0.13.0
fi
if test terraformer >/dev/null 2>&1; then
    echo "terraformer exists. Skip ..." 
else
    export PROVIDER=all
    curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/$(curl -s https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest | grep tag_name | cut -d '"' -f 4)/terraformer-${PROVIDER}-linux-amd64
    chmod +x terraformer-${PROVIDER}-linux-amd64
    sudo chown root:root terraformer-${PROVIDER}-linux-amd64
    sudo mv terraformer-${PROVIDER}-linux-amd64 /usr/local/bin/terraformer
fi

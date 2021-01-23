#!/bin/bash

if type tfenv >/dev/null 2>&1; then
    echo "tfenv exists. Skip ..."
else
    git clone https://github.com/tfutils/tfenv.git ~/.tfenv
    #echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
    sudo ln -s ~/.tfenv/bin/* /usr/local/bin
fi
if type terraform >/dev/null 2>&1; then
    echo "terraform exists. Skip ..."
else
    tfenv install
    tfenv install 0.13.6
# terraformer works with up to this version
    tfenv use 0.13.6
#    sudo apt install -y terraform=0.13.0
fi
if type terraformer >/dev/null 2>&1; then
    echo "terraformer exists. Skip ..." 
else
    export PROVIDER=all
    curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/$(curl -s https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest | grep tag_name | cut -d '"' -f 4)/terraformer-${PROVIDER}-linux-amd64
    chmod +x terraformer-${PROVIDER}-linux-amd64
    sudo chown root:root terraformer-${PROVIDER}-linux-amd64
    sudo mv terraformer-${PROVIDER}-linux-amd64 /usr/local/bin/terraformer
fi

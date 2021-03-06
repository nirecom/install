#!/bin/bash

if type tfenv >/dev/null 2>&1; then
    echo "tfenv exists. Skip ..."
else
    #    [ -d ~/.tfenv ] && rm -rf ~/.tfenv
    #    git clone https://github.com/tfutils/tfenv.git ~/.tfenv
    #    #echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bash_profile
    anyenv install tfenv
fi
echo "Installing terraform..."
#    sudo apt install -y terraform=0.13.0
tfenv install
tfenv use latest
#    sudo ln -sf ~/.tfenv/bin/* /usr/local/bin

# Install terraformer
if type terraformer >/dev/null 2>&1; then
    echo "terraformer exists. Skip ..."
else
    echo "Installing terraformer..."
    export PROVIDER=all
    curl -LO https://github.com/GoogleCloudPlatform/terraformer/releases/download/$(curl -s https://api.github.com/repos/GoogleCloudPlatform/terraformer/releases/latest | grep tag_name | cut -d '"' -f 4)/terraformer-${PROVIDER}-linux-amd64
    chmod +x terraformer-${PROVIDER}-linux-amd64
    sudo chown root:root terraformer-${PROVIDER}-linux-amd64
    sudo mv terraformer-${PROVIDER}-linux-amd64 /usr/local/bin/terraformer
fi

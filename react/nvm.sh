#!/bin/bash
# Install nvm, node, npm
# ref. https://qiita.com/sansaisoba/items/242a8ba95bf70ba179d3
if type nvm >/dev/null 2>&1; then
    echo "nvm is already installed. Skip."
else
    if [ "$(uname)" == 'Darwin' ]; then
        brew install nvm
        export NVM_DIR="$HOME/.nvm"
        [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
        [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
    elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
    fi
    echo "Installed nvm."
    nvm -v
fi
if type node >/dev/null 2>&1; then
    echo "node is already installed. Skip."
else
    nvm install --lts
    nvm use --lts
    nvm alias default lts/*
    node -v
fi

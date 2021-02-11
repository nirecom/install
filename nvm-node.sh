#!/bin/bash
source ./bin/detectos.sh

# Install nvm, node, npm
# ref. https://qiita.com/sansaisoba/items/242a8ba95bf70ba179d3
if type nvm >/dev/null 2>&1; then
    echo "nvm is already installed. Skip."
else
    if [ "$OSDIST" = "macos" ]; then
        brew install nvm
        export NVM_DIR="$HOME/.nvm"
        if "$ISM1"; then
            [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
            [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
        else
            [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
            # may too heavy on old macbook :(
            [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
        fi
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
exec $SHELL -l

# should be installed locally e.g. npm install eslint
#if type eslint >/dev/null 2>&1; then
#    echo "eslint is already installed. Skip."
#else
#    npm install -g eslint
#    npm install -g eslint-plugin-react
#fi

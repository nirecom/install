#!/bin/bash
# Install anyenv
source ./bin/detectos.sh

if type anyenv >/dev/null 2>&1; then
    echo "anyenv is already installed. Skip."
else
    echo "Installing anyenv..."

    case "$OSDIST" in
        "macos" )
            brew install anyenv
            eval "$(anyenv init -)"
            anyenv install --init
            ;;
        "ubuntu" )
            if [ ! -d ~/.anyenv ]; then
                git clone https://github.com/anyenv/anyenv ~/.anyenv
            fi
            ~/.anyenv/bin/anyenv install --init
            ;;
        "amazon" )
            # ref https://caramelcase.com/aws-anyanv-rubyenv-nodenv/#toc4
            cd /usr/local
            if [ ! -d /usr/local/anyenv ]; then
                sudo git clone https://github.com/anyenv/anyenv
            fi
            sudo chgrp -R wheel anyenv
            sudo chmod -R g+rwxXs anyenv
            cd /etc/profile.d/
            if [ ! -f anyenv.sh ]; then
                sudo cp -p ~/install/anyenv-profile.sh anyenv.sh
                sudo chown root.wheel anyenv.sh
                exec $SHELL -l
            fi
            echo "Running anyenv install --init..."
            anyenv install --init
            exec $SHELL -l
            ;;
        * )
            echo "Not supported OS."
            exit 1
    esac
fi

if [ -d $(anyenv root)/plugins/anyenv-update ]; then
    echo "anyenv-update is already installed. Updating..."
    anyenv update
    exit 1
else
    echo "Installing anyenv-update..."
    mkdir -p $(anyenv root)/plugins
    git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
fi

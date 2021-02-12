#!/bin/bash
# Install anyenv
source ./bin/detectos.sh

case "$OSDIST" in
    "macos" )
        brew install anyenv
        eval "$(anyenv init -)"
        ;;
    "ubuntu" )
        if [ ! -d ~/.anyenv ]; then
            git clone https://github.com/anyenv/anyenv ~/.anyenv
        fi
        ;;
    * )
        echo "Not supported OS."
        exit 1
esac
~/.anyenv/bin/anyenv install --init

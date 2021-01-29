#!/bin/bash
cd
curl -L https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.22.6-stable.zip -o ~/flutter.zip

if ! type unzip /dev/null 2>&1; then
    if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
        sudo apt get unzip
    fi
fi
unzip ~/flutter.zip
export PATH="$PATH:$HOME/development/flutter/bin"

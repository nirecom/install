#!/bin/bash
# Install flutter
# ref. https://qiita.com/tomy0610/items/896dc8ec9ba95c33194f
if ! type flutter >/dev/null 2>&1; then
    cd
    curl -L https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.22.6-stable.zip -o ~/flutter.zip

    if ! type unzip /dev/null 2>&1; then
        if [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
            sudo apt get unzip
        fi
    fi
    DESTDIR="$HOME/development"
    mkdir -p $DESTDIR
    cd $DESTDIR
    unzip ~/flutter.zip
    export PATH="$PATH:$DESTDIR/flutter/bin"
    rm ~/flutter.zip
fi
flutter doctor

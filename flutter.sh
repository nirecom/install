#!/bin/bash
# Install flutter
# ref. https://qiita.com/tomy0610/items/896dc8ec9ba95c33194f
if [ "$(uname)" == 'Darwin' ]; then
    if ! type gem >/dev/null 2>&1; then
        echo "Run ruby.sh first to install gem"
        exit 1
    fi
fi
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
echo "Installing CocoaPods for Xcode ..."
sudo gem install cocoapods
pod setup

sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch

# Change channel, otherwise flutter doctor does not detect Android Studio plugin.
# ref. https://stackoverflow.com/questions/52336654/android-studio-flutter-and-dart-plugins-not-recognized-by-flutter-doctor-but-p
flutter channel beta
flutter doctor

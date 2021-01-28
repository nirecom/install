#!/bin/bash
FOLDER="$HOME/.emacs.d"
ZIPSTEM=evernote-mode-0_21
if [ ! -d "$FOLDER" ]; then
    mkdir -p "$FOLDER"
fi
cd "$FOLDER"
curl -L https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/emacs-evernote-mode/$ZIPSTEM.zip -o $ZIPSTEM.zip
unzip $ZIPSTEM.zip
rm $ZIPSTEM.zip
mv $ZIPSTEM evernote-mode
gem install -r thrift
cd evernote-mode
ruby ruby/setup.rb

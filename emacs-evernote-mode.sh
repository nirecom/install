#!/bin/bash

FOLDER="$HOME/.emacs.d"
if [ ! -d "$FOLDER" ]; then
    mkdir -p "$FOLDER"
fi
cd "$FOLDER"
curl -L https://storage.googleapis.com/google-code-archive-source/v2/code.google.com/emacs-evernote-mode/source-archive.zip -o source-archive.zip
unzip source-archive.zip
rm source-archive.zip

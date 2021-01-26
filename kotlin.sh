#!/bin/bash
type zip >/dev/null 2>&1 || sudo apt install zip
type unzip >/dev/null 2>&1 || sudo apt install unzip
if ! type sdk >/dev/null 2>&1; then
    curl -s https://get.sdkman.io | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

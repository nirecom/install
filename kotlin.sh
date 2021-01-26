#!/bin/bash
# Install SDKMAN + java + kotlin
# ref. https://qiita.com/n0bisuke/items/686c1717a894713fdd06
type zip >/dev/null 2>&1 || sudo apt install zip
type unzip >/dev/null 2>&1 || sudo apt install unzip
if ! type sdk >/dev/null 2>&1; then
    curl -s https://get.sdkman.io | bash
    # Run the part that is automatically added at the tail of .bashrc
	export SDKMAN_DIR="$HOME/.sdkman"
#	[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
    source "$HOME/.sdkman/bin/sdkman-init.sh"

fi

type kotlin >/dev/null 2>&1 || sdk install kotlin
type java >/dev/null 2>&1 || sdk install java
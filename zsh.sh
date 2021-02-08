#!/bin/bash
source ./bin/detectos.sh

echo "Installing zsh ..."
if [ "$OSDIST" = "mingw" ]; then
    echo "mingw does not support zsh. Abort."
    exit 1
fi

[ ! -e /bin/zsh ] && sudo apt install -y zsh
if [ ! "`echo $SHELL | grep zsh`" ]; then
    echo "Changing shell to zsh. Enter password ..."
    chsh -s $(which zsh)
fi

if [ ! -d $HOME/.zinit ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi

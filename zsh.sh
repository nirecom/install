#!/bin/bash
echo "Installing zsh ..."
if [[ "$(uname)" != 'Darwin' ]] && [[ "$(expr substr $(uname -s) 1 5)" != 'Linux' ]]; then
    echo "Not supported OS. Abort."
    exit 1
fi

[ ! -e /bin/zsh ] && sudo apt install -y zsh
if [ ! "`echo $SHELL | grep zsh`" ]; then
    echo "Changing shell to zsh. Enter password ..."
    chsh -s $(which zsh)
fi
if [ ! -e ~/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

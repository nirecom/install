#!/bin/bash
[ ! -f /bin/zsh ] && sudo apt install -y zsh
if [ $SHELL != "/bin/zsh" ]; then
    echo "Changing shell to zsh. Enter password ..."
    chsh -s $(which zsh)
fi

if [ ! -e ~/.zsh/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

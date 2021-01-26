#!/bin/bash
# Install emacs
if ! type emacs >/dev/null 2>&1; then
    if [ "$(uname)" == 'Darwin' ]; then
        brew install emacs
    elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
        # ref. https://qiita.com/MasahiroBW/items/f263e7a3dcfe69ec0561
        sudo apt install -y emacs
    else
	echo "not supported OS. Install manually."
    fi
fi

[ ! -d ~/tmp ] && mkdir ~/tmp
[ ! -d ~/.emacs_backup ] && mkdir ~/.emacs_backup

if [ -f ~/.emacs.d/packages/package-init.el ]; then
    emacs --script ~/.emacs.d/packages/package-init.el
fi

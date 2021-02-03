#!/bin/bash
# Install emacs
echo "Installing emacs ..."
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

echo "Creating tmp / backup folders ..."
[ ! -d ~/tmp ] && mkdir ~/tmp
[ ! -d ~/.emacs_backup ] && mkdir ~/.emacs_backup

FPATH="$HOME/dotfiles/.emacs.d/package-install.el"
if [ -f $FPATH ]; then
    echo "Installing packages ..."
    emacs --script $FPATH
fi

# Support Copy & Paste at macos side
if [ "$(uname)" == 'Darwin' ]; then
    echo "Installing reattach-to-user-namespace ..."
    brew install reattach-to-user-namespace
fi

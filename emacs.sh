#!/bin/bash
# Install emacs
source ./bin/detectos.sh

echo "Installing emacs ..."
if ! type emacs >/dev/null 2>&1; then
    if [ "$OSDIST" = "macos" ]; then
        brew install emacs
    elif [ "$OSDIST" = "ubuntu" ]; then
        # ref. https://qiita.com/MasahiroBW/items/f263e7a3dcfe69ec0561
        sudo apt install -y emacs
    elif [ "$OSDIST" = "amazon" ]; then
        sudo yum install -y emacs
    else
        echo "not supported OS. Install manually."
    fi
fi

echo "Creating tmp / backup folders ..."
[ ! -d ~/tmp ] && mkdir ~/tmp
[ ! -d ~/.emacs_backup ] && mkdir ~/.emacs_backup

INSTALLER="$HOME/dotfiles/.emacs.d/package-install.el"
if [ -f $INSTALLER ]; then
    echo "Installing packages ..."
    emacs --script $INSTALLER
fi

#echo "Git cloning tools ..."
#GDIR=$HOME/.emacs.d/git
#mkdir -p $GDIR
#cd $GDIR
#if [ ! -f git-complete.el ]; then
#    curl -L https://raw.githubusercontent.com/zk-phi/git-complete/master/git-complete.el -o git-complete.el
#fi

# Support Copy & Paste at macos side
if [ "$OSDIST" = "macos" ]; then
    echo "Installing reattach-to-user-namespace ..."
    brew install reattach-to-user-namespace
fi

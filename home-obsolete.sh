#!/bin/bash
# Uninstall obsolete files

if [ -L $HOME/.bash_logout ]; then
    echo "symbolic link .bash_logout exists. Removing..."
    rm $HOME/.bash_logout
fi

if [ -L $HOME/.vim ]; then
    echo "symbolic link .vim exists. Removing..."
    rm $HOME/.vim
fi

if [ -L $HOME/.gitconfig ]; then
    echo "symbolic link .gitconfig exists. Removing...(Will use .config/git/config)"
    rm $HOME/.gitconfig
fi

GDIR=$HOME/.emacs.d/git
if [ -d $GDIR ]; then
    echo "emacs: found git clone dir for non-packaged. Removing..."
    rm -r $HOME/.emacs.d/git
fi

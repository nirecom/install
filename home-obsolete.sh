#!/bin/bash
# Uninstall obsolete files

echo "Uninstall emacs: git cloning dir ..."
GDIR=$HOME/.emacs.d/git
if [ ! -d $GDIR ]; then
    rm -r $HOME/.emacs.d/git
fi

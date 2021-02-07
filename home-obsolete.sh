#!/bin/bash
# Uninstall obsolete files

echo "Uninstall emacs: git cloning dir ..."
GDIR=$HOME/.emacs.d/git
if [ -d $GDIR ]; then
    echo "Found. Removing ..."
    rm -r $HOME/.emacs.d/git
fi

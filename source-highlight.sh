#!/bin/bash
echo "Installing source-highlight ..."
if [ "$(uname)" == 'Darwin' ]; then
    brew install source-highlight
    export LDIR="/usr/local/bin"
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    sudo apt install -y source-highlight
    export LDIR="/usr/share/source-highlight"
else
    echo "Not supported OS. Abort."
    exit 1
fi
export LESSOPEN="| $LDIR/src-hilite-lesspipe.sh %s"
export LESS='-R'

echo "Customizing color table ..."
DDIR=$HOME/dotfiles/source-highlight
if [ -f $DDIR/esc.style ]; then
    sudo mv $LDIR/esc.style $LDIR/esc.style.orig
    sudo cp $DDIR/esc.style $LDIR
    sudo chmod 644 $LDIR/esc.style
    sudo chown root:root $LDIR/esc.style
fi
exec $SHELL -l

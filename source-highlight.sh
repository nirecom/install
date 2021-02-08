#!/bin/bash
# Source Highlighting for less command
source ./bin/detectos.sh

echo "Installing less source-highlight ..."
if [ "$OSDIST" = "macos" ]; then
    brew install source-highlight
    export SHAREDIR="/usr/local/share/source-highlight"
    export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
elif [ "$OSDIST" = "ubuntu" ]; then
    sudo apt install -y source-highlight
    export SHAREDIR="/usr/share/source-highlight"
    export LESSOPEN="| $SHAREDIR/src-hilite-lesspipe.sh %s"
elif [ "$OSDIST" = "amazon" ]; then
    sudo yum install -y source-highlight
    export SHAREDIR="/usr/share/source-highlight"
    export LESSOPEN="| $SHAREDIR/src-hilite-lesspipe.sh %s"
else
    echo "Not supported OS. Abort."
    exit 1
fi
export LESS='-R'

echo "Customizing color table ..."
LOCALDIR=$HOME/dotfiles/source-highlight
if [ -f $LOCALDIR/esc.style ]; then
    sudo mv $SHAREDIR/esc.style $SHAREDIR/esc.style.orig
    sudo cp $LOCALDIR/esc.style $SHAREDIR
    sudo chmod 644 $SHAREDIR/esc.style
    if [ "OSDIST" = "ubuntu" ] || [ "OSDIST" = "amazon" ]; then
        sudo chown root:root $SHAREDIR/esc.style
    fi
fi
exec $SHELL -l

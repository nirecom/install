#!/bin/bash
echo "Installing source-highlight ..."
if [ "$(uname)" == 'Darwin' ]; then
    brew install source-highlight
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    sudo apt install -y source-highlight
else
    echo "Not supported OS. Abort."
    exit 1
fi
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS='-R'
exec $SHELL -l

#!/bin/bash
echo "Installing source-highlight ..."
if [ "$(uname)" == 'Darwin' ]; then
    brew install source-highlight
    export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    sudo apt install -y source-highlight
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
else
    echo "Not supported OS. Abort."
    exit 1
fi
export LESS='-R'
exec $SHELL -l

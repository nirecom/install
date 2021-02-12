#!/bin/bash
source ./bin/detectos.sh

# Install node, npm via anyenv
case "$OSDIST" in
    "macos" )
        brew install node
        # want to use nodeenv, but M1 mac takes too long to compile
        ;;
    "ubuntu" )
        anyenv install nodenv
        if type node >/dev/null 2>&1; then
            echo "node is already installed. Skip."
        else
            NODVER=$(nodenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
            nodenv install $NODVER
            nodenv global $NODVER
            node -v
        fi
        ;;
    * )
        echo "Not supported OS."
        exit 1
esac
exec $SHELL -l

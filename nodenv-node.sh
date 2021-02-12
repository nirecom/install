#!/bin/bash
source ./bin/detectos.sh

# Install node, npm via anyenv
case "$OSDIST" in
    "macos" )
        brew install node
        # so far M1 mac takes too long with nodenv / nvm, due to full compilation...
        ;;
    "ubuntu" )
        anyenv install nodenv
        if type node >/dev/null 2>&1; then
            echo "node is already installed. Skip."
        else
            NODVER=$(nodenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
            # 15.8.0 takes too long time to install
            nodenv install 15.7.0
            node -v
        fi
        ;;
    * )
        echo "Not supported OS."
        exit 1
esac
exec $SHELL -l

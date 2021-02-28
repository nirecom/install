#!/bin/bash
# Install anyenv
source ./bin/detectos.sh

case "$OSDIST" in
    "macos" )
        brew install anyenv
        eval "$(anyenv init -)"
        ;;
    "ubuntu" )
        if [ ! -d ~/.anyenv ]; then
            git clone https://github.com/anyenv/anyenv ~/.anyenv
        fi
        ;;
    "amazon" )
        cd /usr/local
        sudo git clone https://github.com/anyenv/anyenv
        sudo chgrp -R wheel anyenv
        sudo chmod -R g+rwxXs anyenv
        cd /etc/profile.d/
        cat >anyenv.sh
export ANYENV_ROOT="/usr/local/anyenv"
export ANYENV_DEFINITION_ROOT="/usr/local/anyenv/share/anyenv-install"
export PATH="${ANYENV_ROOT}/bin:${PATH}"
eval "$(anyenv init --no-rehash -)"
EOF
        ;;
    * )
        echo "Not supported OS."
        exit 1
esac
~/.anyenv/bin/anyenv install --init

#!/bin/bash
# Install anyenv
source ./bin/detectos.sh

if type anyenv >/dev/null 2>&1; then
    echo "anyenv is already installed. Skip."
    exit 1
fi
echo "Installing anyenv..."

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
        # ref https://caramelcase.com/aws-anyanv-rubyenv-nodenv/#toc4
        cd /usr/local
        sudo git clone https://github.com/anyenv/anyenv
        sudo chgrp -R wheel anyenv
        sudo chmod -R g+rwxXs anyenv
        cd /etc/profile.d/
        cat <<EOF >anyenv.sh
export ANYENV_ROOT="/usr/local/anyenv"
export ANYENV_DEFINITION_ROOT="/usr/local/anyenv/share/anyenv-install"
export PATH="${ANYENV_ROOT}/bin:${PATH}"
eval "$(anyenv init --no-rehash -)"
EOF
        anyenv install --init
        exec $SHELL -l
        ;;
    * )
        echo "Not supported OS."
        exit 1
esac
~/.anyenv/bin/anyenv install --init

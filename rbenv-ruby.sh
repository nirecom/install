#!/bin/bash
# Install rbenv and ruby
source ./bin/detectos.sh

if ! type rbenv >/dev/null 2>&1; then
    case "$OSDIST" in
        "ubuntu" )
            sudo apt update
            # Necessary packages for rbenv
            # ref. https://github.com/rbenv/ruby-build/wiki
            sudo apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
            cd ~/install
            git clone https://github.com/rbenv/rbenv.git ~/.rbenv
            git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
            #export PATH="$HOME/.rbenv/bin:$PATH
            source ~/.bash_profile
            ~/.rbenv/bin/rbenv init
            # relaunch shell
            exec $SHELL -l
            ;;
        "macos" )
            echo "Installing rbenv..."
            arch -x86_64 /usr/local/bin/brew install rbenv
            echo "Installing ruby-build..."
            brew install ruby-build
            ;;
        * )
            echo "Not supported. Skip."
            exit 1
    esac
fi

# Install latest stable version of ruby
# ref. https://mawatari.jp/archives/install-latest-stable-version-of-ruby-using-rbenv
# note: It did not work well: `rbenv install -l | grep -v - | tail -1`
RBVER=$(rbenv install -l | sed -n '/^[[:space:]]*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}[[:space:]]*$/ h;${g;p;}')
rbenv install $RBVER
rbenv global $RBVER

exec $SHELL -l

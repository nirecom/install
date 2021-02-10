#!/bin/bash
# Install brew and git
source ./bin/detectos.sh

if [ "$OSDIST" != "macos" ]; then
    echo "Skipping git installation only for macos..."
    exit 1
fi

# Install Brew on macos
BREWPATH=/opt/homebrew/bin/brew
if [ "$OSDIST" = "macos" ]; then
    if [ ! -e "$BREWPATH"  ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    # brew shellenv will be done at .profile_common under dotfiles/ repository
#    if [ ! grep "$BREWPATH" $HOME/.profile >/dev/null 2&>1 ]; then
#        echo 'eval $(/opt/homebrew/bin/brew shellenv)' >>$HOME/.profile
#    fi
#    if [ ! grep "$BREWPATH" $HOME/.profile >/dev/null 2&>1 ]; then
#        echo 'eval $(/opt/homebrew/bin/brew shellenv)' >>$HOME/.zprofile
#    fi
    eval $(/opt/homebrew/bin/brew shellenv)
fi

# two dependencies of git
# https://github.com/Homebrew/discussions/discussions/439
#brew reinstall gettext pcre2

brew install git

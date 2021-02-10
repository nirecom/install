#!/bin/bash
# Initializa User: nire
source ./bin/detectos.sh

USERNAME=nire
BUCKET=nirecom-home

if [ `whoami` != "$USERNAME" ]; then
    echo "Run with user: nire. Abort."
    exit 1
fi

# Install Brew on macos
BREWPATH=/opt/homebrew/bin/brew
if [ "$OSDIST" = "macos" ]; then
    if [ ! -e "$BREWPATH"  ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    if [ ! grep "$BREWPATH" $HOME/.profile >/dev/null 2&>1 ]; then
        echo 'eval $(/opt/homebrew/bin/brew shellenv)' >>$HOME/.profile
    fi
    if [ ! grep "$BREWPATH" $HOME/.profile >/dev/null 2&>1 ]; then
        echo 'eval $(/opt/homebrew/bin/brew shellenv)' >>$HOME/.zprofile
    fi
    eval $(/opt/homebrew/bin/brew shellenv)
fi

# Install aws cli
~/install/awscli.sh

# .ssh/config exists from scratch to git clone this install repository...
#if [ ! -e ~/.ssh/config ]; then
if [ ! -e ~/.ssh/ssh-add-all ]; then
    aws s3 cp --recursive s3://$BUCKET/.ssh ~/.ssh
    chmod 400 ~/.ssh/id*
    chmod +x ~/.ssh/ssh-add-all
fi
if [ ! -d ~/dotfiles ]; then
    cd
    git clone git@github.com:nirecom/dotfiles.git
    dotfiles/bin/dotfileslink.sh
fi

~/install/zsh.sh
~/install/git-completion.sh
~/install/vim.sh
~/install/emacs.sh
~/install/source-highlight.sh

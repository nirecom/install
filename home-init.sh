#!/bin/bash
# Initializa User: nire

BUCKET=nirecom-home

if [ `whoami` != "nire" ]; then
    echo "Run with user: nire. Abort."
    exit 1
fi

# .ssh/config exists from scratch to git clone this install repository...
#if [ ! -e ~/.ssh/config ]; then
if [ ! -e ~/.ssh/ssh-add-all ]; then
    ~/install/awscli.sh
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

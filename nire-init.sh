#!/bin/bash
# Initializa User: nire
BUCKET=nirecom-home

if [ `whoami` != "nire" ]; then
    echo "Run with user: nire. Abort."
    exit 1
fi
if [ ! -d ~/.ssh/config ]; then
    aws configure
    aws s3 cp --recursive s3://$BUCKET/.ssh ~/.ssh
    chmod +x ~/.ssh/ssh-add-all
fi
if [ ! -d ~/dotfiles ]; then
    cd
    git clone git@github.com:nirecom/dotfiles.git
    dotfiles/dotfileslink.sh
fi

./install/vim.sh
./install/emacs.sh

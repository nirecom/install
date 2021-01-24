#!/bin/bash
BUCKET=nirecom-home
aws configure
aws s3 cp --recursive s3://$BUCKET/.ssh ~/.ssh
chmod +x ~/.ssh/ssh-add-all

cd
git clone git@github.com:nirecom/dotfiles.git
dotfiles/dotfileslink.sh

./install/vim.sh
./install/emacs.sh



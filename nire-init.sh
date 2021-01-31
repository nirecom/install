#!/bin/bash
# Initializa User: nire
BUCKET=nirecom-home

if [ `whoami` != "nire" ]; then
    echo "Run with user: nire. Abort."
    exit 1
fi

[ ! -f /bin/zsh ] && sudo apt install -y zsh
if [ $SHELL != "/bin/zsh" ]; then
    echo "Changing shell to zsh. Enter password ..."
    chsh -s $(which zsh)
fi

if [ ! -d ~/.ssh/config ]; then
    ~/install/awscli.sh
    aws configure
    aws s3 cp --recursive s3://$BUCKET/.ssh ~/.ssh
    chmod +x ~/.ssh/ssh-add-all
fi
if [ ! -d ~/dotfiles ]; then
    cd
    git clone git@github.com:nirecom/dotfiles.git
    dotfiles/dotfileslink.sh
fi

~/install/git-completion.sh
~/install/vim.sh
~/install/emacs.sh
~/install/source-highlight.sh

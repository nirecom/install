#!/bin/bash
# Initializa User: nire
source ./bin/detectos.sh

USERNAME=nire
BUCKET=nirecom-home

if [ `whoami` != "$USERNAME" ]; then
    echo "Run with user: nire. Abort."
    exit 1
fi

# Install brew and git on macos (if not macos, will be skipped)
~/install/brew-git.sh
# Install aws cli
~/install/awscli.sh
~/install/dotfiles.sh
~/install/zsh.sh
~/install/git-completion.sh
~/install/vim.sh
~/install/emacs.sh
~/install/source-highlight.sh

#!/bin/bash
# Initialize Ubuntu

# Check current user name
USERNAME=nire
if [ -n $WSLENV ]; then
    if [ `whoami` != $USERNAME ]; then
        echo "It's WSL environment."
        echo "Run with user: $USERNAME. Abort."
        exit 1
    fi
else
    if [ `whoami` != "ubuntu" ]; then
        echo "It's standard ubuntu environment."
        echo "Run with user: ubuntu. Abort."
        exit 1
    fi
fi

sudo apt update && sudo apt -y upgrade
sudo apt install -y language-pack-ja-base language-pack-ja
#sudo apt ibus-mozc
sudo timedatectl set-timezone Asia/Tokyo
# AllowAgentForwarding
./sshd.sh
# Install awscli and ecscli
./awscli.sh
if [ -z $WSLENV ] && ! getent passwd $USERNAME >/dev/null 2>&1; then
    # Create user
    echo "Creating user $USERNAME ..."
    sudo adduser $USERNAME
    sudo gpasswd -a $USERNAME sudo
    sudo cp -pr ~/.ssh /home/$USERNAME/
    sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh/
fi
# Added to sudoers
./sudoers.sh

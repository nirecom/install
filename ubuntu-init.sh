#!/bin/bash
# Initialize Ubuntu with default user ubuntu
if [ `whoami` != "ubuntu" ]; then
    echo "Run with user: ubuntu. Abort."
    exit 1
fi
sudo apt update && sudo apt -y upgrade
sudo timedatectl set-timezone Asia/Tokyo
# AllowAgentForwarding
./sshd.sh
# Create user nire
USERNAME=nire
if ! getent passwd $USERNAME > /dev/null 2>&1; then
    echo "Creating user $USERNAME ..."
    sudo adduser $USERNAME
    sudo gpasswd -a $USERNAME sudo
    sudo cp -pr ~/.ssh /home/$USERNAME/
    sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh/
fi
# Added it to sudoers
./sudoers.sh
# Install awscli and ecscli
./awscli.sh

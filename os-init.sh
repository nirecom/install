#!/bin/bash
# Initialize Ubuntu
source ./bin/detectos.sh

# Check current user name
USERNAME=nire
if "$ISWSL"; then
    if [ `whoami` != $USERNAME ]; then
        echo "It's WSL environment."
        echo "Run with user: $USERNAME. Abort."
        exit 1
    fi
else
    echo "It's non-WSL environment."
    if [ "$OSDIST" = "ubuntu" ] && [ `whoami` != "ubuntu" ]; then
        echo "Run with user: ubuntu. Abort."
        exit 1
    fi
    if [ `whoami` != "ec2-user" ]; then
        echo "Run with user: ec2-user. Abort."
        exit 1
    fi
fi

if [ "$OSDIST" = "ubuntu" ]; then
    sudo apt update && sudo apt -y upgrade
    sudo apt install -y language-pack-ja-base language-pack-ja
    #sudo apt ibus-mozc
    if ! $ISWSL; then
        sudo timedatectl set-timezone Asia/Tokyo
    fi
fi

# AllowAgentForwarding
./sshd.sh
# Install awscli and ecscli
./awscli.sh
if ! $ISWSL && ! getent passwd $USERNAME >/dev/null 2>&1; then
    # Create user
    echo "Creating user $USERNAME ..."
    case "$OSDIST" in
        "ubuntu" )
            sudo adduser $USERNAME
            sudo gpasswd -a $USERNAME sudo
            ;;
        "amazon" )
            sudo useradd $USERNAME
            sudo usermod -G wheel $USERNAME
            ;;
    esac
    sudo cp -pr ~/.ssh /home/$USERNAME/
    sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh/
fi
# Added to sudoers
./sudoers.sh

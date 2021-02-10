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
    case "$OSDIST" in
        "ubuntu" )
            if [ `whoami` != "ubuntu" ]; then
                echo "Run with user: ubuntu. Abort."
                exit 1
            fi
            break ;;
        "amazon" )
            if [ `whoami` != "ec2-user" ]; then
                echo "Run with user: ec2-user. Abort."
                exit 1
            fi
    esac
fi

# Update Packages, Create $USERNAME
case "$OSDIST" in
    "ubuntu" )
        sudo apt update && sudo apt -y upgrade
        sudo apt install -y language-pack-ja-base language-pack-ja
        #sudo apt ibus-mozc
        if ! $ISWSL; then
            sudo timedatectl set-timezone Asia/Tokyo
        fi
        ./sshd.sh
        if ! $ISWSL && ! getent passwd $USERNAME >/dev/null 2>&1; then
            echo "Creating user $USERNAME ..."
            sudo adduser $USERNAME
            sudo gpasswd -a $USERNAME sudo
            sudo cp -pr ~/.ssh /home/$USERNAME/
            sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh/
        fi
        break
        ;;
    "amazon" )
        sudo yum -y update
        ./sshd.sh
        if ! getent passwd $USERNAME >/dev/null 2>&1; then
            echo "Creating user $USERNAME ..."
            sudo useradd $USERNAME
            sudo usermod -G wheel $USERNAME
            sudo cp -pr ~/.ssh /home/$USERNAME/
            sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh/
        fi
esac

# Added to sudoers
./sudoers.sh


#!/bin/bash
# Allow the user to run sudo without password
FILENAME="/etc/sudoers.d/nirecom-users"
if [ ! -f /etc/sudoers.d/nirecom-users ]; then
    sudo sh -c 'echo "nire    ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/nirecom-users'
    sudo chmod 440 $FILENAME
    if [ "$(uname)" == 'Darwin' ]; then
        sudo chown root:wheel $FILENAME
    elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
        sudo chown root:root $FILENAME
    fi
fi

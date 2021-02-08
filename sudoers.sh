#!/bin/bash
source ./bin/detectos.sh

# Allow the user to run sudo without password
FILENAME="/etc/sudoers.d/nirecom-users"
if [ ! -f /etc/sudoers.d/nirecom-users ]; then
    sudo sh -c 'echo "nire    ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/nirecom-users'
    sudo chmod 440 $FILENAME
    if [ "$OSDIST" = "macos" ]; then
        sudo chown root:wheel $FILENAME
    elif [ "$OSDIST" = "ubuntu" ] || [ "$OSDIST" = "amazon" ]; then
        sudo chown root:root $FILENAME
    fi
fi

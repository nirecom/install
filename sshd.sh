#!/bin/bash
source ./bin/detectos.sh

if [ "$OSDIST" = "mingw" ] || $ISWSL; then
    echo "no /etc/ssh. Abort."
    exit 1
fi

# Allow Agentforwarding to SSH
sudo grep -q -E '^ *AllowAgentForwarding' /etc/ssh/sshd_config
if [ $? -gt 0 ]; then
    echo "Adding AllowAgentForwarding ..."
    sudo sh -c 'echo "#nn Added by sshd.sh" >>/etc/ssh/sshd_config'
    sudo sh -c 'echo "AllowAgentForwarding yes" >>/etc/ssh/sshd_config'
fi
sudo systemctl restart ssh

#!/bin/bash
source ./bin/detectos.sh

# Install AWS CLI
if [ "$OSDIST" = "mingw" ]; then
    echo "MINGW is not supported. Please install Windows installer manually."
    exit 1
fi

if [ "$OSDIST" = "amazon" ]; then
    echo "no need to install awscli."
else
    if [ ! -d ~/awscli ]; then
        echo Creating directory ~/awscli .....
        mkdir ~/awscli
    fi
    cd ~/awscli
    if type aws >/dev/null 2>&1; then
        echo "aws command exists. Skipping install ..."
    else
        echo "Installing awscli ..."
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        sudo apt install -y unzip
        unzip awscliv2.zip
        sudo ./aws/install --update
    fi
fi

if [ -e $HOME/.aws/credentials ]; then
    echo "awscli is already configured. Skip aws configure..."
else
    aws configure
fi

# ECS CLI
# ref. https://qiita.com/homines22/items/bf21b2da9345086b3b3f
if type ecs-cli >/dev/null 2>&1; then
    echo "ecs-cli exists. Skipping install ..."
else
    echo "Install ecs-cli ..."
    cd ~/awscli
    sudo curl -o /usr/local/bin/ecs-cli https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
    case "$OSDIST" in
        "ubuntu" )
            sudo apt install -y --no-install-recommends gnupg ;;
        "amazon" )
            sudo yum install -y gnupg ;;
    esac
    gpg --keyserver hkp://keys.gnupg.net --recv BCE9D9A42D51784F
    curl -o ecs-cli.asc https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest.asc
    gpg --verify ecs-cli.asc /usr/local/bin/ecs-cli
    sudo chmod +x /usr/local/bin/ecs-cli
    ecs-cli --version
fi

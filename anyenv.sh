#!/bin/bash
brew install anyenv
eval "$(anyenv init -)"
anyenv install --init
exec $SHELL -l

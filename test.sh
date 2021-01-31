#!/bin/bash
if [ -n $WSLENV ]; then
	echo "WSL."
fi

if [ -z $WSLENV ]; then
	echo "non WSL."
else
	echo "2: WSL."
fi

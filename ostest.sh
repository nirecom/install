#!/bin/bash
source ./bin/detectos.sh

echo OSDIST=$OSDIST
echo ISWSL=$ISWSL
if [ "$OSDIST" = "ubuntu" ]; then
    echo "passed ubuntu test!"
fi
if "$ISWSL"; then
    echo "passed wsl test!"
fi

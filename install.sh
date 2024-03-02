#!/usr/bin/env bash

# Check if running on WSL2
if grep -qi Microsoft /proc/version; then
    echo "Running on Windows Subsystem for Linux 2 (WSL2)"
    ./install-windows.sh
else
    # Check for other Linux distributions
    if grep -qi arch /etc/*release; then
        echo "Running on Arch Linux"
        ./install-arch.sh
    elif grep -qi fedora /etc/*release; then
        echo "Running on Fedora"
        ./install-fedora.sh
    else
        echo "Running on an unrecognized Linux distribution"
    fi
fi

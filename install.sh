#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

os="$(uname -s)"
case "$os" in
  Darwin)
    echo "Running on macOS"
    ./install-scripts/install-macos.sh || exit 1
    ;;
  Linux)
    if grep -qi Microsoft /proc/version; then
      echo "Running on Windows Subsystem for Linux 2 (WSL2)"
      ./install-scripts/install-windows.sh || exit 1
    elif grep -qi arch /etc/*release; then
      echo "Running on Arch Linux"
      ./install-scripts/install-arch.sh || exit 1
    else
      echo "Running on an unrecognized Linux distribution"
    fi
    ;;
  *)
    echo "Unsupported OS: $os"
    exit 1
    ;;
esac

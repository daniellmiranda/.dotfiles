#!/usr/bin/env bash

# pulls and updates submodules
git submodule init
git submodule update

stow -t "$HOME" zsh
stow -t "$HOME" git
cp ./wsl/.wslconfig /mnt/c/Users/daniellmiranda
cp ./windows-terminal/settings.json /mnt/c/Users/daniellmiranda/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState
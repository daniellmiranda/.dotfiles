#!/usr/bin/env bash

# pulls and updates submodules
git submodule init
git submodule update

ZSHRC=$HOME/.zshrc
ZSH_ALIASES=$HOME/.zsh_aliases
GITCONFIG=$HOME/.wslconfig

# zsh
test -f ZSHRC && rm ZSHRC
test -f ZSH_ALIASES && rm ZSH_ALIASES
stow -t "$HOME" zsh

# git
test -f GITCONFIG && rm GITCONFIG 
stow -t "$HOME" git

# wsl2
cp ./wsl/.wslconfig /mnt/c/Users/daniellmiranda

# windows terminal
cp ./windows-terminal/settings.json /mnt/c/Users/daniellmiranda/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState

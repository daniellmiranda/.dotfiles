#!/usr/bin/env bash

# pulls and updates submodules
git submodule init
git submodule update

# files paths
ZSHRC=$HOME/.zshrc
ZSH_ALIASES=$HOME/.zsh_aliases
OMZ_DIR=$HOME/.oh-my-zsh
GITCONFIG=$HOME/.gitconfig
WSLCONFIG=/mnt/c/Users/daniellmiranda
WINDOWS_TERMINAL=/mnt/c/Users/daniellmiranda/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState

# packages to be installed
packages=('git' 'zsh' 'paru' 'stow')

for i in $packages; do
  if ! pacman -Qi $i > /dev/null 2>&1; then
    sudo pacman -S $i > /dev/null 2>&1
  fi
done

# zsh
rm -f $ZSHRC
rm -f $ZSH_ALIASES
stow -t ~ zsh

# git
rm -f $GITCONFIG 
stow -t "$HOME" git

# wsl2
cp -f ./wsl/.wslconfig /mnt/c/Users/daniellmiranda

# windows terminal
cp ./windows-terminal/settings.json $WINDOWS_TERMINAL

# installs oh my zsh
if ! [ -d "$OMZ_DIR" ] > /dev/null 2>&1; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# installs/updates zinit
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

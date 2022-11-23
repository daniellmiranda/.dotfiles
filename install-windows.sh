#!/usr/bin/env bash

# This script should be run in Windows 10 or Windows 11 with WSL2 and Arch Linux (https://github.com/yuk7/ArchWSL)

# script path
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# files paths
ZSHRC=$HOME/.zshrc
ZSH_ALIASES=$HOME/.zsh_aliases
GITCONFIG=$HOME/.gitconfig
WINDOWS_TERMINAL=/mnt/c/Users/daniellmiranda/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState

# packages to be installed (in official Arch repos)
packages=('git' 'zsh' 'stow' 'bat' 'reflector' 'neofetch' 'exa' 'flatpak')
packages_groups=('base-devel')

for i in ${packages[@]}; do
  if ! pacman -Qi $i > /dev/null 2>&1; then
    sudo pacman -S $i --noconfirm
  fi
done

for i in ${packages_groups[@]}; do
  if ! pacman -Qg $i > /dev/null 2>&1; then
    sudo pacman -S $i --noconfirm
  fi
done

# installs Aura Package Manager from the AUR
if ! pacman -Qi aura-bin > /dev/null 2>&1; then
  cd $HOME
  git clone https://aur.archlinux.org/aura-bin.git
  cd aura-bin
  makepkg -si --noconfirm
  cd $HOME
  sudo rm -r aura-bin
  cd $SCRIPT_DIR
fi

# installs Pazi from AUR
if ! pacman -Qi pazi > /dev/null 2>&1; then
  sudo aura -A pazi --noconfirm
fi

# installs ASDF from AUR
if ! pacman -Qi pazi > /dev/null 2>&1; then
  sudo aura -A asdf-vm --noconfirm
fi

# antigen
curl -L git.io/antigen > $HOME/antigen.zsh

# zsh
rm -f $ZSHRC
rm -f $ZSH_ALIASES
stow -t $HOME zsh

# git
rm -f $GITCONFIG 
stow -t $HOME git

# windows terminal
cp ./windows-terminal/settings.json $WINDOWS_TERMINAL

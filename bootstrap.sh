#!/usr/bin/env bash

# script path
script_path=${pwd}

# files paths
ZSHRC=$HOME/.zshrc
ZSH_ALIASES=$HOME/.zsh_aliases
OMZ_DIR=$HOME/.oh-my-zsh
GITCONFIG=$HOME/.gitconfig
WSLCONFIG=/mnt/c/Users/daniellmiranda
WINDOWS_TERMINAL=/mnt/c/Users/daniellmiranda/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState

# packages to be installed (in official Arch repos)
packages=('git' 'zsh' 'stow' 'bat' 'reflector' 'neofetch')
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
  cd $script_path
fi

# installs Pazi from AUR
if ! pacman -Qi pazi > /dev/null 2>&1; then
  sudo aura -A pazi --noconfirm
fi

# zsh
rm -f $ZSHRC
rm -f $ZSH_ALIASES
stow -t $HOME zsh

# git
rm -f $GITCONFIG 
stow -t $HOME git

# wsl2 - comment to disable ram limit
cp -f ./wsl/.wslconfig /mnt/c/Users/daniellmiranda

# windows terminal
cp ./windows-terminal/settings.json $WINDOWS_TERMINAL



# install/update nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

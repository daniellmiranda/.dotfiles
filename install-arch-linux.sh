#!/usr/bin/env bash

# This script should be run in Arch Linux

# script path
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# files paths
ZSHRC=$HOME/.zshrc
ZSH_ALIASES=$HOME/.zsh_aliases
GITCONFIG=$HOME/.gitconfig

# packages to be installed
packages=('git' 'zsh' 'stow' 'bat' 'reflector' 'neofetch' 'exa' 'sof-firmware' 'docker' 'docker-compose' 'dbeaver' 'gnome-themes-extra' 'wget')
packages_groups=('base-devel')
aur_packages=('visual-studio-code-bin' 'brave-bin' 'pazi')

# install packages in official repositories
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

# installs packages from AUR
for i in ${aur_packages[@]}; do
  if ! pacman -Qi $i > /dev/null 2>&1; then
    sudo aura -A $i --noconfirm
  fi
done

# antigen
curl -L git.io/antigen > $HOME/antigen.zsh

# zsh
rm -f $ZSHRC
rm -f $ZSH_ALIASES
stow -t $HOME zsh

# git
rm -f $GITCONFIG 
stow -t $HOME git

# install/update nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

# install JetBrainsMono NerdFont
cd $SCRIPT_DIR
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ./JetBrainsMonoNerdFont
mv JetBrainsMonoNerdFont $HOME/.fonts
rm -r ./JetBrainsMonoNerdFont
rm ./JetBrainsMono.zip


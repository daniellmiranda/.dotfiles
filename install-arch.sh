#!/usr/bin/env bash

# This script should be run in Arch Linux

# script path
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# files paths
ZSHRC=$HOME/.zshrc
ZSH_ALIASES=$HOME/.zsh_aliases
GITCONFIG=$HOME/.gitconfig

# packages to be installed
packages=('stow' 'git' 'zsh' 'zoxide' 'fzf' 'bat' 'reflector' 'neofetch' 'eza' 'sof-firmware' 'docker' 'dbeaver' 'gnome-themes-extra' 'wget' 'flatpak')
packages_groups=('base-devel')
aur_packages=('zsh-antidote' 'visual-studio-code-bin')
flatpak_packages=('com.raggesilver.BlackBox')

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

for i in ${flatpak_packages[@]}; do
  if ! pacman -Qg $i > /dev/null 2>&1; then
    flatpak install flathub $i
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

# installs packages from AUR
for i in ${aur_packages[@]}; do
  if ! pacman -Qi $i > /dev/null 2>&1; then
    sudo aura -A $i --noconfirm
  fi
done

# zsh
rm -f $ZSHRC
rm -f $ZSH_ALIASES
stow -t $HOME zsh
chsh -s $(which zsh)

# git
rm -f $GITCONFIG 
stow -t $HOME git

# install JetBrainsMono NerdFont
cd $SCRIPT_DIR
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ./JetBrainsMonoNerdFont
mv JetBrainsMonoNerdFont $HOME/.fonts
rm -r ./JetBrainsMonoNerdFont
rm ./JetBrainsMono.zip

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

# packages to be installed (in official Arch repos)
packages=('git' 'zsh' 'base-devel' 'stow' 'bat')

for i in $packages; do
  if ! pacman -Qi $i > /dev/null 2>&1; then
    sudo pacman -S $i > /dev/null 2>&1
  fi
done

# installs Aura Package Manager from the AUR
if ! pacman -Qi aura-bin > /dev/null 2>&1; then
  cd $HOME
  git clone https://aur.archlinux.org/aura-bin.git
  cd aura-bin
  makepkg -si
  rm -r aura-bin
fi


# installs Pazi from AUR
if ! pacman -Qi pazi > /dev/null 2>&1; then
  sudo aura -A pazi
fi

# install/update nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

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

# # adds zinit plugins
if ! grep -q "# Zinit plugins" $ZSHRC; then
  echo "
# Zinit plugins
zinit light denysdovhan/spaceship-prompt
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions" >> $ZSHRC
fi

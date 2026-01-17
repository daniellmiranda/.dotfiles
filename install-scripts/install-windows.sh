#!/usr/bin/env bash

# This script should be run in Windows 10 or Windows 11 with WSL2 and Arch Linux (https://wiki.archlinux.org/title/Install_Arch_Linux_on_WSL)

# script path
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Get the Windows username
WINDOWS_USERNAME=$(powershell.exe -c "Write-Host -NoNewLine ([Environment]::UserName)")

# files paths
ZSHRC=$HOME/.zshrc
GITCONFIG=$HOME/.gitconfig
WINDOWS_TERMINAL=/mnt/c/Users/$WINDOWS_USERNAME/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/

# packages to be installed (in official Arch repos)
packages=('stow' 'git' 'zsh' 'zoxide' 'fzf' 'bat' 'reflector' 'eza')
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
# if ! pacman -Qi aura-bin > /dev/null 2>&1; then
#   cd $HOME
#   git clone https://aur.archlinux.org/aura-bin.git
#   cd aura-bin
#   makepkg -si --noconfirm
#   cd $HOME
#   sudo rm -r aura-bin
#   cd $SCRIPT_DIR
# fi

# zsh
rm -f $ZSHRC
stow -t $HOME zsh

# git
rm -f $GITCONFIG
stow -t $HOME git

# windows terminal
cp ./windows-terminal/settings.json $WINDOWS_TERMINAL

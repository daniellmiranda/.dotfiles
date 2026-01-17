#!/usr/bin/env bash

# This script should be run in Arch Linux

UTILS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/utils"

source "$UTILS_DIR/common.sh"
source "$UTILS_DIR/packages.sh"
source "$UTILS_DIR/dotfiles.sh"

SCRIPT_DIR=$(get_script_dir)
DOTFILES_ROOT="$(dirname "$SCRIPT_DIR")"

packages=('stow' 'git' 'zsh' 'zoxide' 'fzf' 'bat' 'reflector' 'eza' 'sof-firmware' 'docker' 'gnome-themes-extra' 'wget' 'flatpak' 'zed')
packages_groups=('base-devel')
aur_packages=('zsh-antidote' 'visual-studio-code-bin')
# flatpak_packages=('')

install_packages "${packages[@]}"
install_package_groups "${packages_groups[@]}"

# for i in ${flatpak_packages[@]}; do
#   if ! pacman -Qg $i > /dev/null 2>&1; then
#     flatpak install flathub $i
#   fi
# done

install_aura "$SCRIPT_DIR"
install_aur_packages "${aur_packages[@]}"

setup_zsh "$DOTFILES_ROOT"
change_shell_to_zsh
setup_git "$DOTFILES_ROOT"

# Install GeistMono NerdFont
cd "$SCRIPT_DIR" || exit 1
echo "Installing GeistMono NerdFont..."

if ! wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/GeistMono.zip; then
  echo "Error: Failed to download GeistMono font" >&2
  exit 1
fi

if ! unzip GeistMono.zip -d ./GeistMonoNerdFont; then
  echo "Error: Failed to extract GeistMono font" >&2
  rm -f GeistMono.zip
  exit 1
fi

mkdir -p "$HOME/.fonts" || {
  echo "Error: Failed to create .fonts directory" >&2
  rm -rf ./GeistMonoNerdFont
  rm -f GeistMono.zip
  exit 1
}

mv GeistMonoNerdFont "$HOME/.fonts/" || {
  echo "Error: Failed to move font to .fonts directory" >&2
  rm -rf ./GeistMonoNerdFont
  rm -f GeistMono.zip
  exit 1
}

rm -f GeistMono.zip
echo "GeistMono NerdFont installed successfully"

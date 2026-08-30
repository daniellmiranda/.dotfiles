#!/usr/bin/env bash

# This script should be run on macOS (tested with macOS Tahoe)

UTILS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/utils"

source "$UTILS_DIR/common.sh"
source "$UTILS_DIR/packages-macos.sh"
source "$UTILS_DIR/dotfiles.sh"

SCRIPT_DIR=$(get_script_dir)
DOTFILES_ROOT="$(dirname "$SCRIPT_DIR")"

packages=('stow' 'git' 'zsh' 'zoxide' 'fzf' 'bat' 'eza' 'antidote' 'starship' 'gh' 'neovim' 'gnupg' 'pinentry-mac')
casks=('docker-desktop')

ensure_homebrew || exit 1
install_brew_packages "${packages[@]}" || exit 1
install_brew_casks "${casks[@]}" || exit 1

setup_zsh "$DOTFILES_ROOT" "zsh-macos" || exit 1
setup_git "$DOTFILES_ROOT" || exit 1

BREW_ZSH="$(brew --prefix)/bin/zsh"
if ! grep -qx "$BREW_ZSH" /etc/shells; then
  echo "Adding $BREW_ZSH to /etc/shells..."
  echo "$BREW_ZSH" | sudo tee -a /etc/shells > /dev/null || {
    echo "Error: Failed to add zsh to /etc/shells" >&2
    exit 1
  }
fi
change_shell_to_zsh "$BREW_ZSH"

GPG_AGENT_CONF="$HOME/.gnupg/gpg-agent.conf"
PINENTRY="$(brew --prefix)/bin/pinentry-mac"
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
if [ ! -f "$GPG_AGENT_CONF" ] || ! grep -q '^pinentry-program ' "$GPG_AGENT_CONF"; then
  echo "Configuring pinentry-mac for GPG..."
  echo "pinentry-program $PINENTRY" >> "$GPG_AGENT_CONF"
fi

echo "macOS setup complete. Launch Docker.app once so the docker CLI is available, then restart the terminal."

#!/usr/bin/env bash

# This script should be run in Windows 10 or Windows 11 with WSL2 and Arch Linux (https://wiki.archlinux.org/title/Install_Arch_Linux_on_WSL)

UTILS_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )/utils"

source "$UTILS_DIR/common.sh"
source "$UTILS_DIR/packages.sh"
source "$UTILS_DIR/dotfiles.sh"

SCRIPT_DIR=$(get_script_dir)
DOTFILES_ROOT="$(dirname "$SCRIPT_DIR")"

WINDOWS_USERNAME=$(powershell.exe -c "Write-Host -NoNewLine ([Environment]::UserName)")

# Expand wildcard to find actual Windows Terminal directory
WINDOWS_TERMINAL_PATTERN=/mnt/c/Users/$WINDOWS_USERNAME/AppData/Local/Packages/Microsoft.WindowsTerminal_*/LocalState/
WINDOWS_TERMINAL=$(ls -d $WINDOWS_TERMINAL_PATTERN 2>/dev/null | head -n 1)

if [ -z "$WINDOWS_TERMINAL" ]; then
  echo "Warning: Windows Terminal directory not found at $WINDOWS_TERMINAL_PATTERN" >&2
  WINDOWS_TERMINAL=""
fi

packages=('stow' 'git' 'zsh' 'zoxide' 'fzf' 'bat' 'reflector' 'eza')
packages_groups=('base-devel')

install_packages "${packages[@]}"
install_package_groups "${packages_groups[@]}"
install_aura "$SCRIPT_DIR"

setup_zsh "$DOTFILES_ROOT"
setup_git "$DOTFILES_ROOT"

WINDOWS_TERMINAL_SETTINGS="$DOTFILES_ROOT/windows-terminal/settings.json"
if [ -f "$WINDOWS_TERMINAL_SETTINGS" ]; then
  if [ -n "$WINDOWS_TERMINAL" ] && [ -d "$WINDOWS_TERMINAL" ]; then
    echo "Copying Windows Terminal settings..."
    cp "$WINDOWS_TERMINAL_SETTINGS" "$WINDOWS_TERMINAL" || {
      echo "Error: Failed to copy Windows Terminal settings" >&2
    }
  else
    echo "Warning: Windows Terminal directory not found, skipping settings copy..." >&2
  fi
else
  echo "Warning: $WINDOWS_TERMINAL_SETTINGS not found, skipping..." >&2
fi

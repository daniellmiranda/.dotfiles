#!/usr/bin/env bash

# Usage: setup_dotfile dotfile_name target_dir [file_to_remove] [dotfiles_root_dir]
setup_dotfile() {
  local dotfile_name="$1"
  local target_dir="${2:-$HOME}"
  local file_to_remove="$3"
  local dotfiles_root="${4:-$(pwd)}"
  
  if [ -n "$file_to_remove" ]; then
    if [ -f "$file_to_remove" ] || [ -L "$file_to_remove" ]; then
      echo "Removing existing $file_to_remove..."
      rm -f "$file_to_remove"
    fi
  fi
  
  echo "Setting up $dotfile_name dotfiles..."
  cd "$dotfiles_root" || return 1
  stow -t "$target_dir" "$dotfile_name" || {
    echo "Error: Failed to stow $dotfile_name" >&2
    return 1
  }
}

# Usage: setup_zsh [dotfiles_root_dir] os_zsh_package
# os_zsh_package is zsh-linux or zsh-macos. Common files live in zsh-common.
setup_zsh() {
  local dotfiles_root="${1:-$(pwd)}"
  local os_package="$2"
  local zshrc="$HOME/.zshrc"
  local plugins="$HOME/.zsh_plugins.txt"

  if [ -z "$os_package" ]; then
    echo "Error: OS zsh package required (zsh-linux or zsh-macos)" >&2
    return 1
  fi

  # Pre-create so stow links files instead of folding the whole directory
  # into the first package (which would block the OS overlay).
  mkdir -p "$HOME/.config/zsh" || return 1

  if [ -f "$plugins" ] || [ -L "$plugins" ]; then
    echo "Removing existing $plugins..."
    rm -f "$plugins"
  fi

  setup_dotfile "zsh-common" "$HOME" "" "$dotfiles_root" || return 1
  setup_dotfile "$os_package" "$HOME" "$zshrc" "$dotfiles_root" || return 1
}

# Usage: setup_git [dotfiles_root_dir]
setup_git() {
  local dotfiles_root="${1:-$(pwd)}"
  local gitconfig="$HOME/.gitconfig"
  
  setup_dotfile "git" "$HOME" "$gitconfig" "$dotfiles_root"
}

# Usage: change_shell_to_zsh [zsh_path]
change_shell_to_zsh() {
  local zsh_path="${1:-$(command -v zsh)}"
  if [ -z "$zsh_path" ]; then
    echo "Error: zsh not found in PATH" >&2
    return 1
  fi
  
  echo "Changing default shell to zsh..."
  chsh -s "$zsh_path" || {
    echo "Error: Failed to change shell to zsh" >&2
    return 1
  }
}

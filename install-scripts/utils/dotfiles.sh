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

# Usage: setup_zsh [dotfiles_root_dir]
setup_zsh() {
  local dotfiles_root="${1:-$(pwd)}"
  local zshrc="$HOME/.zshrc"
  
  setup_dotfile "zsh" "$HOME" "$zshrc" "$dotfiles_root"
}

# Usage: setup_git [dotfiles_root_dir]
setup_git() {
  local dotfiles_root="${1:-$(pwd)}"
  local gitconfig="$HOME/.gitconfig"
  
  setup_dotfile "git" "$HOME" "$gitconfig" "$dotfiles_root"
}

# Usage: change_shell_to_zsh
change_shell_to_zsh() {
  local zsh_path=$(which zsh)
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

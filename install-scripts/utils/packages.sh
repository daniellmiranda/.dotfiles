#!/usr/bin/env bash

# Usage: install_packages packages_array
install_packages() {
  local packages=("$@")
  for package in "${packages[@]}"; do
    if ! pacman -Qi "$package" > /dev/null 2>&1; then
      echo "Installing $package..."
      sudo pacman -S "$package" --noconfirm || {
        echo "Error: Failed to install $package" >&2
        return 1
      }
    else
      echo "$package is already installed, skipping..."
    fi
  done
}

# Usage: install_package_groups groups_array
install_package_groups() {
  local groups=("$@")
  for group in "${groups[@]}"; do
    if ! pacman -Qg "$group" > /dev/null 2>&1; then
      echo "Installing package group $group..."
      sudo pacman -S "$group" --noconfirm || {
        echo "Error: Failed to install package group $group" >&2
        return 1
      }
    else
      echo "Package group $group is already installed, skipping..."
    fi
  done
}

# Usage: install_aura [script_dir]
install_aura() {
  local script_dir="${1:-$HOME}"
  local original_dir=$(pwd)
  
  if ! pacman -Qi aura > /dev/null 2>&1; then
    echo "Installing Aura Package Manager from AUR..."
    cd "$HOME" || return 1
    
    if [ -d "aura" ]; then
      echo "Warning: aura directory already exists, removing it..."
      sudo rm -rf aura
    fi
    
    git clone https://aur.archlinux.org/aura.git || {
      echo "Error: Failed to clone aura repository" >&2
      cd "$original_dir"
      return 1
    }
    
    cd aura || {
      echo "Error: Failed to enter aura directory" >&2
      cd "$original_dir"
      return 1
    }
    
    makepkg -si --noconfirm || {
      echo "Error: Failed to build/install aura" >&2
      cd "$original_dir"
      return 1
    }
    
    cd "$HOME" || return 1
    sudo rm -rf aura
    cd "$script_dir" || return 1
    echo "Aura Package Manager installed successfully"
  else
    echo "Aura is already installed, skipping..."
  fi
}

# Usage: install_aur_packages aur_packages_array
install_aur_packages() {
  local aur_packages=("$@")
  for package in "${aur_packages[@]}"; do
    if ! pacman -Qi "$package" > /dev/null 2>&1; then
      echo "Installing $package from AUR..."
      sudo aura -A "$package" --noconfirm || {
        echo "Error: Failed to install $package from AUR" >&2
        return 1
      }
    else
      echo "$package is already installed, skipping..."
    fi
  done
}

#!/usr/bin/env bash

# Usage: ensure_homebrew
ensure_homebrew() {
  if command -v brew > /dev/null 2>&1; then
    echo "Homebrew is already installed, skipping..."
    return 0
  fi

  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo "Homebrew is already installed, skipping..."
    return 0
  fi

  if [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
    echo "Homebrew is already installed, skipping..."
    return 0
  fi

  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    echo "Error: Failed to install Homebrew" >&2
    return 1
  }

  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  else
    echo "Error: Homebrew installed but brew was not found on PATH" >&2
    return 1
  fi
}

# Usage: install_brew_packages packages_array
install_brew_packages() {
  local packages=("$@")
  for package in "${packages[@]}"; do
    if brew list --formula "$package" > /dev/null 2>&1; then
      echo "$package is already installed, skipping..."
    else
      echo "Installing $package..."
      brew install "$package" || {
        echo "Error: Failed to install $package" >&2
        return 1
      }
    fi
  done
}

# Usage: install_brew_casks casks_array
install_brew_casks() {
  local casks=("$@")
  for cask in "${casks[@]}"; do
    if brew list --cask "$cask" > /dev/null 2>&1; then
      echo "$cask is already installed, skipping..."
    else
      echo "Installing cask $cask..."
      brew install --cask "$cask" || {
        echo "Error: Failed to install cask $cask" >&2
        return 1
      }
    fi
  done
}

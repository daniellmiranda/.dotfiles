# Arch Linux / WSL. Sourced from ~/.zshrc after common.zsh.

alias i='sudo pacman -S'
alias r='sudo pacman -Rscn'
alias up='aura -Syu && aura -Au && aura -Oj'
alias upmr='sudo reflector --latest 10 --country BR,CL,US --protocol https --sort rate --save /etc/pacman.d/mirrorlist'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Turso
export PATH="$PATH:$HOME/.turso"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# Java
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$PATH:$JAVA_HOME/bin

# Android
export ANDROID_HOME=$HOME/Android
export PATH=$PATH:$HOME/Android/cmdline-tools/latest/bin
export PATH=$PATH:"$ANDROID_HOME/platform-tools"
alias adb=$ANDROID_HOME"/platform-tools/adb.exe"

# Vite+ bin (https://viteplus.dev)
[ -s "$HOME/.vite-plus/env" ] && . "$HOME/.vite-plus/env"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

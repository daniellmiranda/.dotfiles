export GPG_TTY=$(tty)

source /usr/share/zsh-antidote/antidote.zsh

antidote load

# aliases
alias i='sudo pacman -S'
alias r='sudo pacman -Rscn'
alias up='aura -Syu && aura -Au && aura -Oj'
alias ls='eza -al --color=always --icons --group-directories-first --git'
alias vim='nvim'
alias upmr='sudo reflector --latest 10 --country BR,CL,US --protocol https --sort rate --save /etc/pacman.d/mirrorlist'
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
gp() {
  git add .
  git commit -m "$1"
  git push
}
alias dps='docker ps --format="ID\t{{.ID}}\nNAME\t{{.Names}}\nImage\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"'

# eza
export EZA_COLORS="uu=31:da=37"

# Zoxide
eval "$(zoxide init zsh --cmd cd)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/daniellmiranda/.bun/_bun" ] && source "/home/daniellmiranda/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Turso
export PATH="$PATH:/home/daniellmiranda/.turso"

# pnpm
export PNPM_HOME="/home/daniellmiranda/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Java
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$PATH:$JAVA_HOME/bin

# Android
export ANDROID_HOME="$HOME/Android"
export PATH=$PATH:"$ANDROID_HOME/cmdline-tools/tools"
export PATH=$PATH:"$ANDROID_HOME/cmdline-tools/tools/bin"
export PATH=$PATH:"$ANDROID_HOME/platform-tools"
alias adb=$ANDROID_HOME"/platform-tools/adb.exe"

eval "$(starship init zsh)"

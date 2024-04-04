### GPG
export GPG_TTY=$(tty)

# Antidote
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load Pure Prompt on startup
autoload -U promptinit; promptinit
prompt powerlevel10k

# Aliases
source ~/.zsh_aliases

# Eza
export LS_COLORS="di=31:*.git*=38;5;202:*.js=33:*.ts=34:*.md=37"
export EZA_COLORS="uu=31:da=37"

# PNPM
export PNPM_HOME="/home/$USER/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Bun
[ -s "/home/$USER/.bun/_bun" ] && source "/home/$USER/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Java
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$PATH:$JAVA_HOME/bin

# Android
export ANDROID_HOME="$HOME/Android"
export PATH=$PATH:"$ANDROID_HOME/cmdline-tools/tools"
export PATH=$PATH:"$ANDROID_HOME/cmdline-tools/tools/bin"
export PATH=$PATH:"$ANDROID_HOME/platform-tools"
alias adb=$ANDROID_HOME"/platform-tools/adb.exe"

# Turso
export PATH="/home/$USER/.turso:$PATH"

# Zoxide
eval "$(zoxide init zsh --cmd cd)"

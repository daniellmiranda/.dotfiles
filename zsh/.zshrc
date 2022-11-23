# Antigen
source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen apply

# ZSH Aliases
source ~/.zsh_aliases

# Theme
ZSH_THEME="starship"

# Plugins
plugins=(
	git
	virtualenv
)

### Pazi
if command -v pazi &>/dev/null; then
  eval "$(pazi init zsh)" # or 'bash'
fi

### Exa
export LS_COLORS="di=31:*.git*=38;5;202:*.js=33:*.ts=34:*.md=37"
export EXA_COLORS="uu=31:da=37"

### ASDF
. /opt/asdf-vm/asdf.sh

### GPG
export GPG_TTY=$(tty)

eval "$(starship init zsh)"

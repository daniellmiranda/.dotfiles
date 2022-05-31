# Antigen
source ~/antigen.zsh
antigen use oh-my-zsh
antigen bundle denysdovhan/spaceship-prompt
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen apply

# ZSH Aliases
source ~/.zsh_aliases

# Theme
ZSH_THEME="spaceship"

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  node          # Node version
  hg            # Mercurial section (hg_branch  + hg_status)
  docker        # Docker section
  venv		      # Virtualenv section
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_VENV_GENERIC_NAMES=true
SPACESHIP_DIR_COLOR=#d31919
SPACESHIP_GIT_BRANCH_COLOR=#FF5252
SPACESHIP_GIT_STATUS_COLOR=#fd7d00
SPACESHIP_VENV_COLOR=#377cf1
SPACESHIP_NODE_SHOW=true
SPACESHIP_DOCKER_SHOW=true

# Plugins
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
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

### Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### PNPM
export PNPM_HOME="/home/daniellmiranda/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Path to your oh-my-zsh installation
export ZSH="/home/daniellmiranda/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Automatically update without prompting
DISABLE_UPDATE_PROMPT="true"

# Plugins
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
	git
	virtualenv
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vi'
fi

# Spaceship oh-my-zsh theme
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
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

### Android Home
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

### Pazi
if command -v pazi &>/dev/null; then
  eval "$(pazi init zsh)" # or 'bash'
fi

### Exa
export LS_COLORS="di=31:.git*=38;5;202:*.js=33:*.ts=34:*.md=37"
export EXA_COLORS="uu=31:da=37"

### Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PNPM_HOME="/home/daniellmiranda/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ZSH Custom
source $HOME/.zsh_aliases

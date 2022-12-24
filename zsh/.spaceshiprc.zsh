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
  # vi_mode       # Vi-mode indicator
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

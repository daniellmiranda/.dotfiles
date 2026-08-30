# Shared by every OS. Sourced from the OS-specific ~/.zshrc.

export GPG_TTY=$(tty)

alias ls='eza -al --color=always --icons --group-directories-first --git'
alias vim='nvim'
alias glog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
gp() {
  git add .
  git commit -m "$1"
  git push
}
alias dps='docker ps --format="ID\t{{.ID}}\nNAME\t{{.Names}}\nImage\t{{.Image}}\nPORTS\t{{.Ports}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.CreatedAt}}\nSTATUS\t{{.Status}}\n"'

export EZA_COLORS="uu=31:da=37"

eval "$(zoxide init zsh --cmd cd)"
eval "$(starship init zsh)"
export PATH="$HOME/.local/bin:$PATH"

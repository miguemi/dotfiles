# aliases
alias vi="nvim"
alias ls='eza -l --icons -s extension'
alias gs="git status"
alias cat="bat"
alias lg="lazygit"

function docker_delete(){
  docker system prune -af && docker volume prune -af
}

# exports
export VISUAL="nvim"
export EDITOR="nvim"
export LC_ALL=en_US.UTF-8
export PATH=/opt/homebrew/bin:$PATH

# Evals
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"



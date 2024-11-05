# aliases
alias vi="nvim"
alias ls='eza -l --icons -s extension'
alias gs="git status"
alias cat="bat"
alias lg="lazygit"

function docker_delete(){
  docker system prune -af && docker volume prune -af
}
function laravel_format(){
  pnpm run blade-format && pnpm run prettier-format && composer run format
}

# exports
export VISUAL="nvim"
export EDITOR="nvim"
export LC_ALL=en_US.UTF-8
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
# android
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# Evals
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"


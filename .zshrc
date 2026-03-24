export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="eastwood"

DISABLE_AUTO_TITLE="true"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Aliases
alias zshconfig="nvim ~/.zshrc"
alias t="tmux attach 2>/dev/null || tmux"
alias ccv="cc -Wall -Werror -Wextra"

export MYVIMRC=$HOME/.vimrc

# Terminal title: show command when running, directory when idle
preexec() {
  print -Pn "\e]0;${1%% *}\a"
}
precmd() {
  local ec=$?
  print -Pn "\e]0;%~\a"
  # Pass last exit code to tmux for status bar
  if [[ -n "$TMUX" ]]; then
    tmux set -p @exit_code "$ec" 2>/dev/null
  fi
}

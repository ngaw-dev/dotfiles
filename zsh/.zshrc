# ===========================
#  ZSH + Oh-My-Zsh + Starship
# ===========================

# Load Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Init Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# Starship Prompt
eval "$(starship init zsh)"

# Basic PATH
export PATH="$HOME/bin:$PATH"

# Aliases
alias ll='ls -la'
alias gs='git status'

alias copyq="QT_QPA_PLATFORM=xcb copyq"

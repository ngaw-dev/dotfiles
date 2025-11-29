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

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

eval "$(zoxide init zsh)"

# Autocorrect
setopt correct

# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

# Aliases
[ -f ~/.aliases ] && source ~/.aliases

# Git auto-completion
autoload -Uz compinit && compinit

# Default editor
export EDITOR="nvim"

# Colors
export TERM="xterm-kitty"


# FZF keybindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

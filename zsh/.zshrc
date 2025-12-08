# ==========================================
#   ZSH — Warp Optimized Configuration
# ==========================================
export PLATFORM="mac"
export EDITOR="nvim"

# ------------------------------------------
# Paths
# ------------------------------------------
[ -f ~/.paths ] && source ~/.paths

# ------------------------------------------
# Oh-My-Zsh (Plugins only, Warp handles UI)
# ------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ------------------------------------------
# Tools
# ------------------------------------------
eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

# ------------------------------------------
# History
# ------------------------------------------
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt sharehistory hist_ignore_all_dups hist_reduce_blanks

# ------------------------------------------
# Aliases
# ------------------------------------------
[ -f ~/.aliases ] && source ~/.aliases

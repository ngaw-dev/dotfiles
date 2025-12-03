# ==========================================
#   ZSH — Warp Optimized Configuration
# ==========================================

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PLATFORM="mac"
else
  export PLATFORM="linux"
fi

# ------------------------------------------
# Homebrew Path (macOS)
# ------------------------------------------
if [[ "$PLATFORM" == "mac" ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

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
# Starship Prompt
# ------------------------------------------
eval "$(starship init zsh)"

# ------------------------------------------
# PATH Config
# ------------------------------------------
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/bin:$PATH"

# ------------------------------------------
# fzf
# ------------------------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ------------------------------------------
# zoxide
# ------------------------------------------
eval "$(zoxide init zsh)"

# ------------------------------------------
# History
# ------------------------------------------
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt sharehistory hist_ignore_all_dups hist_reduce_blanks

# ------------------------------------------
# Default editor
# ------------------------------------------
export EDITOR="nvim"

# ------------------------------------------
# Aliases
# ------------------------------------------
[ -f ~/.aliases ] && source ~/.aliases
export PATH="$HOME/.local/bin:$PATH"

# Added by Antigravity
export PATH="/Users/ngaw/.antigravity/antigravity/bin:$PATH"

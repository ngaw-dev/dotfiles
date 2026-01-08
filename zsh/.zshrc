# ==========================================
#   ZSH — Warp Optimized Configuration
# ==========================================
export PLATFORM="linux"
export EDITOR="nvim"

# ------------------------------------------
# Paths
# ------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# Source custom paths file with error handling
[ -f ~/.paths ] && source ~/.paths || true

# Homebrew - support both standard and Linuxbrew locations
if [ -d /home/linuxbrew/.linuxbrew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -d "$HOME/.linuxbrew" ]; then
    eval "$($HOME/.linuxbrew/bin/brew shellenv)"
fi

# ------------------------------------------
# Oh-My-Zsh (Plugins only, Warp handles UI)
# ------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

# Only load Oh-My-Zsh if it's installed
if [ -d "$ZSH" ]; then
    plugins=(
      git
      zsh-autosuggestions
      zsh-syntax-highlighting
    )

    source $ZSH/oh-my-zsh.sh
else
    echo "Warning: Oh-My-Zsh not found at $ZSH. Skipping Oh-My-Zsh setup." >&2
fi

# ------------------------------------------
# Tools
# ------------------------------------------
# Initialize tools with error handling for missing installations

# Starship prompt
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
else
    echo "Warning: starship not found. Install with: brew install starship" >&2
fi

# Fuzzy finder
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# Zoxide (smart cd)
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
fi

# ------------------------------------------
# History
# ------------------------------------------
# Standardized with bash configuration for consistency
HISTSIZE=10000
SAVEHIST=20000
HISTFILE="$HOME/.zsh_history"
setopt sharehistory hist_ignore_all_dups hist_reduce_blanks

# ------------------------------------------
# Aliases
# ------------------------------------------
# Source aliases with error handling
[ -f ~/.aliases ] && source ~/.aliases || true

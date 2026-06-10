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

# Load nvm
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export EDITOR="code --wait"

export OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS=true

# gtr - Git Worktree Runner - https://github.com/coderabbitai/git-worktree-runner
_gtr_init="${XDG_CACHE_HOME:-$HOME/.cache}/gtr/init-gtr.zsh"
[[ -f "$_gtr_init" ]] || eval "$(git gtr init zsh)" || true
source "$_gtr_init" 2>/dev/null || true; unset _gtr_init

# Load root .env and export variables
ENV_FILE="$HOME/dotfiles/.env"
[[ -f "$ENV_FILE" ]] && set -a && source "$ENV_FILE" && set +a

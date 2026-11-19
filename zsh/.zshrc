# ==========================================
#   ZSH — Warp Optimized Configuration
# ==========================================
export PLATFORM="mac"
export EDITOR="nano"

# ------------------------------------------
# Paths
# ------------------------------------------
[ -f ~/.paths ] && source ~/.paths

# ------------------------------------------
# Zinit (plugin manager)
# ------------------------------------------
typeset -A ZINIT
ZINIT[COMPINIT_OPTS]=-u   # don't abort on insecure Homebrew completion dirs

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME/.git" ]]; then
  mkdir -p "${ZINIT_HOME:h}"
  git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

if [[ -f "$ZINIT_HOME/zinit.zsh" ]]; then
  source "$ZINIT_HOME/zinit.zsh"
  zinit snippet OMZP::git
  zinit light zsh-users/zsh-autosuggestions
fi

# Fallback if Zinit/plugins can't be fetched (e.g. offline first run)
(( $+functions[compdef] )) || { autoload -Uz compinit && compinit -u; }

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
# Option (Alt) key word motions — herdr-safe
# Terminals send modified arrows as ESC[1;3D/C; bind explicitly
# so they work inside herdr/tmux and nested shells.
# ------------------------------------------
bindkey $'\e[1;3D' backward-word    # Option+Left
bindkey $'\e[1;3C' forward-word     # Option+Right
bindkey $'\e^?' backward-kill-word  # Option+Backspace
bindkey $'\e^H' backward-kill-word  # Option+Backspace (alt variant)
bindkey $'\e[3;3~' kill-word        # Option+Delete
bindkey -r "^K"                     # Disable Cmd+K / Ctrl+K

# ------------------------------------------
# Aliases
# ------------------------------------------
[ -f ~/.aliases ] && source ~/.aliases

# Load nvm
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

export OPENCODE_EXPERIMENTAL_BACKGROUND_SUBAGENTS=true

# Load env files and export variables

# gtr - Git Worktree Runner - https://github.com/coderabbitai/git-worktree-runner
_gtr_init="${XDG_CACHE_HOME:-$HOME/.cache}/gtr/init-gtr.zsh"
[[ -f "$_gtr_init" ]] || eval "$(git gtr init zsh)" || true
source "$_gtr_init" 2>/dev/null || true; unset _gtr_init

# Load env files and export variables
ENV_FILE="$HOME/dotfiles/.env"
[[ -f "$ENV_FILE" ]] && set -a && source "$ENV_FILE" && set +a
PERSONAL_ENV="$HOME/personal/.env"
[[ -f "$PERSONAL_ENV" ]] && set -a && source "$PERSONAL_ENV" && set +a

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

# herdr-automatic-rename: live tab naming hook
for _f in $HOME/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.zsh(N); do
  source $_f; break
done

# zsh-syntax-highlighting must load last
if (( $+functions[zinit] )); then
  zinit light zsh-users/zsh-syntax-highlighting
fi

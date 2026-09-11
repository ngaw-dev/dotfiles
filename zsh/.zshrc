# ==========================================
#   ZSH Configuration
# ==========================================
export PLATFORM="mac"
export EDITOR="nvim"

# ------------------------------------------
# Paths
# ------------------------------------------
[ -f ~/.paths ] && source ~/.paths

# ------------------------------------------
# Zinit (plugin manager)
# ------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
unalias zi 2>/dev/null # avoid clobbering zoxide's `zi` (interactive cd)

zinit snippet OMZP::git
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# ------------------------------------------
# Tools
# ------------------------------------------
eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"

. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# ------------------------------------------
# History
# ------------------------------------------
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zsh_history"
setopt sharehistory hist_ignore_all_dups hist_reduce_blanks

# ------------------------------------------
# Herdr tab auto-title (folder name + tab number)
# ------------------------------------------
if [ -n "$HERDR_TAB_ID" ]; then
  _herdr_rename_tab() {
    local num
    num=$(herdr tab list --workspace "$HERDR_WORKSPACE_ID" 2>/dev/null | jq -r --arg id "$HERDR_TAB_ID" '.result.tabs[] | select(.tab_id==$id) | .number')
    if [ -n "$num" ]; then
      herdr tab rename "$HERDR_TAB_ID" "$num: ${PWD:t}" &>/dev/null
    else
      herdr tab rename "$HERDR_TAB_ID" "${PWD:t}" &>/dev/null
    fi
  }
  autoload -Uz add-zsh-hook
  add-zsh-hook chpwd _herdr_rename_tab
  _herdr_rename_tab
fi

# ------------------------------------------
# Keybindings
# ------------------------------------------
bindkey '^K' clear-screen

# ------------------------------------------
# Aliases
# ------------------------------------------
[ -f ~/.aliases ] && source ~/.aliases

# Move cursor word by word with Option + Arrows
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word

# Delete word with Option + Delete (Backspace)
bindkey "\e\x7f" backward-kill-word

# Clear the entire line backward with Cmd + Delete
bindkey "\x15" backward-kill-line

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

# herdr-automatic-rename: live tab naming hook
for _f in $HOME/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.zsh(N); do
  source $_f; break
done

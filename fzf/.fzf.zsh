export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# fzf + ripgrep live search
fif() {
  rg --files | fzf --preview 'batcat --color=always --style=numbers --line-range=:500 {}'
}

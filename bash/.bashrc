# Enable bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

alias ll='ls -la'
. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/home/amol/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

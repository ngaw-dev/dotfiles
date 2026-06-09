# cmux Command Reference

## Topology Commands

| Command | Description |
|---------|-------------|
| `identify` | Print server identity and caller context |
| `tree [--all] [--workspace <id>] [--window <id>]` | Print topology tree |
| `top [--all] [--workspace <id>] [--processes] [--sort cpu\|mem\|proc]` | Resource usage |
| `memory [--all] [--workspace <id>] [--groups <count>]` | Memory usage |
| `list-windows` | List windows |
| `current-window` | Print selected window |
| `new-window` | Create new window |
| `focus-window --window <id>` | Focus a window |
| `close-window --window <id>` | Close a window |
| `list-workspaces [--window <id>]` | List workspaces |
| `current-workspace [--window <id>]` | Print current workspace |
| `new-workspace [--name <title>] [--cwd <path>] [--command <cmd>] [--layout <json>] [--window <id>]` | Create workspace |
| `close-workspace --workspace <id>` | Close a workspace |
| `select-workspace --workspace <id>` | Select/focus a workspace |
| `rename-workspace [--workspace <id>] <title>` | Rename a workspace |
| `move-workspace-to-window --workspace <id> --window <id>` | Move workspace to window |
| `reorder-workspace --workspace <id> (--index <n> \| --before <id> \| --after <id>) [--window <id>]` | Reorder workspace |
| `reorder-workspaces --order <id>,<id>,... [--window <id>]` | Atomic reorder |
| `workspace-action --action <name> [--workspace <id>] [--color <name\|#hex>] [--title <text>] [--description <text>]` | Workspace actions |
| `list-panes [--workspace <id>]` | List panes |
| `list-pane-surfaces [--pane <id>] [--workspace <id>]` | List surfaces in a pane |
| `new-pane [--type terminal\|browser] [--direction <dir>] [--workspace <id>] [--url <url>]` | Create pane |
| `new-split <direction> [--workspace <id>] [--surface <id>]` | Split from surface |
| `focus-pane --pane <id>` | Focus a pane |
| `resize-pane --pane <id> (-L\|-R\|-U\|-D) [--amount <n>]` | Resize a pane |
| `swap-pane --pane <id> --target-pane <id>` | Swap two panes |
| `break-pane [--pane <id>] [--workspace <id>]` | Move pane to new workspace |
| `join-pane --target-pane <id>` | Join pane into another |
| `new-surface [--type terminal\|browser] [--pane <id>] [--workspace <id>] [--url <url>]` | Create surface |
| `close-surface --surface <id>` | Close a surface |
| `move-surface --surface <id> [--pane <id>] [--workspace <id>] [--before\|--after\|--index <n>]` | Move surface |
| `split-off --surface <id> <direction>` | Split surface into new pane |
| `reorder-surface --surface <id> (--index <n> \| --before <id> \| --after <id>)` | Reorder surface |
| `drag-surface-to-split --surface <id> <direction>` | Drag surface to split |
| `surface-health --surface <id>` | Surface health info |
| `trigger-flash [--surface <id>] [--workspace <id>]` | Visual flash cue |
| `refresh-surfaces` | Refresh all surfaces |
| `tab-action --action <name> [--tab <id>] [--surface <id>] [--title <text>] [--url <url>]` | Tab actions |

## Terminal I/O

| Command | Description |
|---------|-------------|
| `send [--surface <id>] <text>` | Send text to terminal |
| `send-key [--surface <id>] <key>` | Send key press |
| `send-panel --panel <id> <text>` | Send text to panel |
| `send-key-panel --panel <id> <key>` | Send key to panel |
| `read-screen [--surface <id>] [--scrollback] [--lines <n>]` | Read terminal output |
| `capture-pane [--surface <id>] [--scrollback] [--lines <n>]` | tmux compat read |
| `clear-history [--surface <id>]` | Clear scrollback |
| `pipe-pane --command <cmd> [--surface <id>]` | Pipe output to command |

## Notifications & Sidebar

| Command | Description |
|---------|-------------|
| `notify --title <text> [--subtitle <text>] [--body <text>] [--workspace <id>]` | Send notification |
| `list-notifications` | List notifications |
| `dismiss-notification (--id <uuid> \| --all-read)` | Dismiss notification |
| `mark-notification-read (--id <uuid> \| --workspace <id> \| --all)` | Mark read |
| `open-notification --id <uuid>` | Open notification |
| `jump-to-unread` | Jump to unread |
| `clear-notifications` | Clear all |
| `set-status <key> <value> [--icon <name>] [--color <#hex>] [--priority <n>]` | Set status pill |
| `clear-status <key>` | Clear status pill |
| `list-status` | List status pills |
| `set-progress <0.0-1.0> [--label <text>]` | Set progress bar |
| `clear-progress` | Clear progress bar |
| `log --level <level> --message <text>` | Append log entry |
| `clear-log` | Clear log |
| `list-log [--limit <n>]` | List log entries |
| `right-sidebar <toggle\|show\|hide\|focus\|set\|mode\|files\|find\|vault\|sessions\|feed\|dock>` | Right sidebar control |

## SSH

| Command | Description |
|---------|-------------|
| `ssh <destination> [--name <title>] [--port <n>] [--identity <path>] [--forward-agent] [--ssh-option <opt>] [-- <cmd>]` | SSH workspace |
| `ssh-session-list [--workspace <id> \| --all-workspaces]` | List SSH sessions |
| `ssh-session-attach --session-id <id>` | Reattach to session |
| `ssh-session-cleanup (--session-id <id> \| --all) [--workspace <id> \| --all-workspaces]` | Cleanup session |

## Browser

See `references/browser-commands.md`.

## Settings & Config

| Command | Description |
|---------|-------------|
| `settings [open <target>]` | Open Settings UI |
| `settings path` | Print config paths |
| `config doctor\|check\|validate [--path <file>]` | Validate config |
| `config path\|paths` | Print config paths |
| `config reload` | Reload config |
| `config get <key>` | Get config value |
| `config set <key> <value>` | Set config value |
| `reload-config` | Reload cmux + Ghostty config |
| `docs settings\|shortcuts\|api\|browser\|agents\|dock\|sidebars` | Print docs URLs |

## Agent Integration

| Command | Description |
|---------|-------------|
| `hooks setup [--agent <name>] [--yes]` | Install agent hooks |
| `hooks uninstall [--agent <name>]` | Remove agent hooks |
| `hooks <agent> install\|uninstall` | Agent-specific hooks |
| `hooks feed --source <agent>` | Feed from agent events |
| `omo [opencode-args...]` | Launch OpenCode with cmux |
| `omx [omx-args...]` | Launch Oh My Codex |
| `omc [omc-args...]` | Launch Oh My Claude Code |
| `claude-teams [claude-args...]` | Claude Code teams |
| `codex-teams [codex-args...]` | Codex teams |

## VM

| Command | Description |
|---------|-------------|
| `vm new \| create [--image <name>] [--provider <name>] [--detach]` | Create VM |
| `vm ls \| list` | List VMs |
| `vm rm \| destroy <id>` | Destroy VM |
| `vm exec <id> <cmd>` | Execute command in VM |
| `vm shell \| attach <id>` | Open VM shell |

## Events & Auth

| Command | Description |
|---------|-------------|
| `events [--after <seq>] [--name <event>] [--reconnect] [--limit <n>]` | Stream events |
| `auth status\|login\|logout` | Authentication |
| `feed tui\|clear` | Feed TUI |
| `themes list\|set\|clear` | Theme management |
| `welcome` | Welcome screen |
| `version` | Version info |
| `capabilities` | List RPC methods |

## Global Options

| Option | Description |
|--------|-------------|
| `--json` | Machine-readable JSON output |
| `--id-format refs\|uuids\|both` | Handle output format |
| `--password <value>` | Socket password |
| `--socket <path>` | Socket path override |
| `--window <id\|ref\|index>` | Target window |

## Workspace Actions

`pin`, `unpin`, `rename`, `clear-name`, `set-description`, `clear-description`,
`move-up`, `move-down`, `move-top`, `close-others`, `close-above`,
`close-below`, `mark-read`, `mark-unread`, `set-color`, `clear-color`

## Tab Actions

`rename`, `clear-name`, `close-left`, `close-right`, `close-others`,
`new-terminal-right`, `new-browser-right`, `reload`, `duplicate`,
`pin`, `unpin`, `mark-unread`

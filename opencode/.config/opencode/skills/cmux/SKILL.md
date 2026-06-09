---
name: cmux
description: >
  Master control of the cmux terminal multiplexer — workspace/layout management,
  browser automation, terminal interaction, sidebar/notifications, SSH sessions,
  settings, agent hooks, and event streams. Also use this skill to manage windows,
  workspaces, panes, surfaces (terminal or browser tabs), and tabs.
  Use whenever cmux is running and you need to open files/URLs in cmux,
  create splits, send terminal input, automate a browser webview, read terminal
  output, configure settings in cmux.json, set up agent hooks, open SSH workspaces,
  use the markdown viewer, manage notifications/status/progress, or inspect
  cmux topology. Triggers on user mentions of "cmux", "pane", "workspace",
  "surface", "split", "sidebar", "browser snapshot", "agent hook",
  "ssh workspace", "markdown viewer", or "cmux settings".
---

# cmux Agent Skill

Control cmux — the terminal multiplexer for macOS. This skill covers workspace/layout
automation, browser webview control, terminal I/O, settings, SSH, notifications,
agent hooks, event streaming, and markdown viewer.

## Core Concepts

- **Window**: top-level macOS window containing workspaces.
- **Workspace**: tab-like group within a window (what the sidebar shows).
- **Pane**: a split region within a workspace.
- **Surface**: a tab inside a pane — can be a **terminal** or a **browser** webview.
- **Tab**: horizontal tab in the surface tab bar (controlled via `tab-action`).

### Handle Model

Inputs accept: UUIDs, short refs (`window:1`, `workspace:2`, `pane:3`, `surface:4`), or
indexes. Short refs are the default output format. Pass `--id-format uuids` or
`--id-format both` when UUIDs are needed (logging, persistence).

### Environment Variables (auto-set in cmux terminals)

| Variable | Purpose |
|----------|---------|
| `CMUX_WORKSPACE_ID` | Default `--workspace` for all commands |
| `CMUX_SURFACE_ID` | Default `--surface` for send/read-screen, etc. |
| `CMUX_SOCKET_PATH` | Override the Unix socket path |
| `CMUX_SOCKET_PASSWORD` | Socket auth fallback |

## Fast Start

```bash
# identify current context
cmux identify --json
printf 'workspace=%s\nsurface=%s\nsocket=%s\n' \
  "${CMUX_WORKSPACE_ID:-}" \
  "${CMUX_SURFACE_ID:-}" \
  "${CMUX_SOCKET_PATH:-}"

# inspect topology
cmux list-windows --json
cmux list-workspaces --json
cmux list-panes --workspace "${CMUX_WORKSPACE_ID:-}" --json
cmux list-pane-surfaces --workspace "${CMUX_WORKSPACE_ID:-}" --json
cmux tree --all

# create workspace / split / surface
cmux new-workspace --name "debug" --cwd "$PWD"
cmux new-pane --workspace "${CMUX_WORKSPACE_ID:-}" --type terminal --direction right
cmux new-surface --workspace "${CMUX_WORKSPACE_ID:-}" --type terminal

# send terminal input
cmux send --surface "${CMUX_SURFACE_ID:-}" "npm run dev\n"
cmux send-key --surface "${CMUX_SURFACE_ID:-}" enter

# read terminal output
cmux read-screen --surface "${CMUX_SURFACE_ID:-}" --lines 40

# browser automation
cmux --json browser open https://example.com
cmux browser surface:7 snapshot --interactive
cmux browser surface:7 click e5 --snapshot-after

# sidebar / status
cmux set-status build "running" --color "#ff9500"
cmux set-progress 0.5 --label "Testing"
cmux notify --title "Done" --body "Build finished"
cmux right-sidebar set feed

# markdown viewer
cmux markdown open plan.md

# SSH workspace
cmux ssh user@host --name "prod-server"
```

## Non-Disruptive Automation

The user may focus on a different workspace, window, or app while the agent works.
**Never assume the visually focused workspace is the right target.**

### Default Rule

Scope all actions to the **caller workspace** (the one that launched the agent) unless
the user explicitly names another target. Use `CMUX_WORKSPACE_ID` and
`CMUX_SURFACE_ID` as the primary anchors.

### Never Call Without Explicit User Ask

These are focus-changing/user-affecting operations that yank the user's attention:

- `select-workspace` — switches sidebar tab
- `focus-pane` / `focus-panel` — yanks pane focus
- `tab-action` with focus-changing actions

### Build Layout Additively

Prefer single-shot creation over create-then-move-then-focus chains:

```bash
# GOOD: pane + content in one call
cmux new-pane --workspace "${CMUX_WORKSPACE_ID:-}" --type browser --direction right --url "http://127.0.0.1:8765"

# GOOD: pass --focus false to preserve user attention
cmux new-split right --workspace "${CMUX_WORKSPACE_ID:-}" --focus false
```

### Right-Side Helper Pane

When opening auxiliary output (preview apps, logs, TUIs, browser checks),
reuse an existing helper pane or create exactly one right-side helper:

```bash
# check existing panes first
cmux list-panes --workspace "${CMUX_WORKSPACE_ID:-}" --json

# if a helper pane exists, add a surface to it
cmux new-surface --workspace "${CMUX_WORKSPACE_ID:-}" --pane pane:3 --type terminal --focus false

# if none exists, create one
cmux new-pane --workspace "${CMUX_WORKSPACE_ID:-}" --type terminal --direction right --focus false
```

## Workspace Management

```bash
# create
cmux new-workspace --name "feature-x" --cwd "$PWD"
cmux new-workspace --name "logs" --command "tail -f /var/log/system.log"

# list / select / rename / close
cmux list-workspaces --json
cmux rename-workspace --workspace workspace:3 "new-name"
cmux close-workspace --workspace workspace:3

# move workspace between windows
cmux move-workspace-to-window --workspace workspace:2 --window window:1

# reorder
cmux reorder-workspace --workspace workspace:3 --index 0
cmux reorder-workspaces --order "workspace:1,workspace:3,workspace:2"

# workspace context-menu actions
cmux workspace-action --action pin --workspace workspace:2
cmux workspace-action --action set-color --workspace workspace:2 --color "#ff9500"
```

## Pane & Surface Management

### Splits

```bash
# create a new split from the current surface
cmux new-split right --workspace "${CMUX_WORKSPACE_ID:-}"
cmux new-split down --workspace "${CMUX_WORKSPACE_ID:-}"

# create a pane with content
cmux new-pane --workspace "${CMUX_WORKSPACE_ID:-}" --type browser --direction right --url "http://localhost:3000" --focus false
cmux new-pane --workspace "${CMUX_WORKSPACE_ID:-}" --type terminal --direction right --focus false
```

### Moving Surfaces

```bash
# reorder within its pane
cmux move-surface --surface surface:7 --before surface:3
cmux move-surface --surface surface:7 --after surface:3
cmux move-surface --surface surface:7 --index 0

# move to another pane
cmux move-surface --surface surface:7 --pane pane:2 --focus false

# split a surface off into its own pane
cmux split-off --surface surface:7 right --focus false
```

### Closing

```bash
cmux close-surface --surface surface:3
cmux close-workspace --workspace workspace:4
cmux close-window --window window:2
```

### Terminal I/O

```bash
# send text or keys
cmux send --surface "${CMUX_SURFACE_ID:-}" "git status\n"
cmux send-key --surface "${CMUX_SURFACE_ID:-}" enter
cmux send-key --surface "${CMUX_SURFACE_ID:-}" ctrl+c

# read screen content
cmux read-screen --surface "${CMUX_SURFACE_ID:-}" --lines 40
cmux read-screen --surface "${CMUX_SURFACE_ID:-}" --scrollback --lines 100

# clear scrollback
cmux clear-history --surface "${CMUX_SURFACE_ID:-}"
```

### Surface Health & Attention

```bash
cmux surface-health --surface surface:7
cmux trigger-flash --surface surface:7
cmux refresh-surfaces
```

### Tab Actions

```bash
cmux tab-action --action rename --surface surface:7 --title "build log"
cmux tab-action --action pin --surface surface:7
cmux move-tab-to-new-workspace --surface surface:7 --title "extracted"
```

## Browser Automation

cmux provides a Playwright-like browser API on surface-backed webviews.

### Core Workflow

```
navigate -> verify -> wait -> snapshot -> act -> snapshot
```

### Open and Target

```bash
# open a URL in a new browser surface
cmux --json browser open https://example.com
# returns surface ref, e.g. surface:7

# target an existing browser surface
cmux browser surface:7 get url
```

### Navigation & Wait

```bash
cmux browser surface:7 goto https://example.com

# wait patterns
cmux browser surface:7 wait --load-state complete --timeout-ms 15000
cmux browser surface:7 wait --selector "#ready" --timeout-ms 10000
cmux browser surface:7 wait --text "Success" --timeout-ms 10000
cmux browser surface:7 wait --url-contains "/dashboard" --timeout-ms 10000
cmux browser surface:7 wait --function "document.readyState === 'complete'" --timeout-ms 10000
```

### Snapshots (the primary inspection tool)

```bash
# interactive snapshot: returns structured element refs (e1, e2, ...)
cmux browser surface:7 snapshot --interactive

# compact snapshot (less detail, faster)
cmux browser surface:7 snapshot --compact

# with cursor position
cmux browser surface:7 snapshot --interactive --cursor
```

### Element Actions

```bash
# fill/type
cmux browser surface:7 fill e1 "Jane Doe"
cmux browser surface:7 fill e2 ""  # clear input
cmux browser surface:7 type e3 "hello"

# click/dblclick/hover
cmux --json browser surface:7 click e5 --snapshot-after
cmux browser surface:7 hover e6

# select/check/uncheck
cmux browser surface:7 select e7 "option-value"
cmux browser surface:7 check e8
cmux browser surface:7 uncheck e8

# scroll
cmux browser surface:7 scroll --dy 500
cmux browser surface:7 scroll-into-view e10
```

### Read Page State

```bash
cmux browser surface:7 get url
cmux browser surface:7 get title
cmux browser surface:7 get text
cmux browser surface:7 get html
cmux browser surface:7 get value e10
cmux browser surface:7 get count "button"
cmux browser surface:7 is visible e1
cmux browser surface:7 is enabled e2
```

### Finding Elements (alternatives to snapshot refs)

```bash
cmux browser surface:7 find first "button"
cmux browser surface:7 find role "heading" --name "Welcome"
cmux browser surface:7 find text "Submit"
cmux browser surface:7 find label "Email"
cmux browser surface:7 find placeholder "Search..."
cmux browser surface:7 find testid "user-profile"
```

### JavaScript Eval

```bash
cmux browser surface:7 eval "document.title"
cmux browser surface:7 eval "JSON.stringify(window.__INITIAL_STATE__)"
```

### Screenshot

```bash
cmux browser surface:7 screenshot --out /tmp/page.png
cmux browser surface:7 screenshot --json  # base64 in JSON
```

### Frame & Dialog Management

```bash
cmux browser surface:7 frame "iframe[name='app']"
cmux browser surface:7 frame main
cmux browser surface:7 dialog accept
cmux browser surface:7 dialog dismiss
```

### Browser Tabs

```bash
cmux browser surface:7 tab new
cmux browser surface:7 tab list
cmux browser surface:7 tab switch 1
cmux browser surface:7 tab close 2
```

### Cookie & Storage

```bash
cmux browser surface:7 cookies get
cmux browser surface:7 cookies set --name "token" --value "abc"
cmux browser surface:7 storage local get "theme"
cmux browser surface:7 storage session set "key" "val"
```

### Profiles & State Persistence

```bash
cmux browser profiles list
cmux browser surface:7 state save /tmp/browser-state.json
cmux browser surface:7 state load /tmp/browser-state.json
```

### Console & Errors

```bash
cmux browser surface:7 console list
cmux browser surface:7 errors list
cmux browser surface:7 console clear
```

### Troubleshooting

If `snapshot --interactive` or `eval` returns `js_error`:

```bash
# fall back to raw DOM extraction
cmux browser surface:7 get url
cmux browser surface:7 get text body
cmux browser surface:7 get html body
```

Also try navigating to a simpler page first, then retrying.

## Settings & Config

### cmux.json — Primary Settings File

Located at `~/.config/cmux/cmux.json` (JSONC format). File watcher auto-reloads on save.
Legacy `~/.config/cmux/settings.json` is read as fallback only for keys absent from `cmux.json`.

**Before editing cmux.json**, back up the file to a timestamped `.bak` next to it.

After editing, reload if needed:
```bash
cmux reload-config
```
This reloads BOTH `cmux.json` and Ghostty config (`~/.config/ghostty/config`) and
refreshes terminals in place — no app restart needed.

### Schema & Reference

- Schema: `https://raw.githubusercontent.com/manaflow-ai/cmux/main/web/data/cmux.schema.json`
- Docs: `cmux docs settings`

### Common Settings (JSON Path → Description)

| Path | Type | Description |
|------|------|-------------|
| `app.appearance` | `"system"\|"light"\|"dark"` | Color scheme |
| `app.menuBarOnly` | bool | Hide dock icon |
| `automation.socketControlMode` | `"off"\|"cmuxOnly"\|"password"\|"allowAll"` | Socket access control |
| `sidebar.hideAllDetails` | bool | Minimal sidebar |
| `sidebarAppearance.tintColor` | `"#RRGGBB"` | Sidebar tint |
| `notifications.sound` | string | Notification sound |
| `browser.defaultSearchEngine` | string | Search engine |
| `browser.hostsToOpenInEmbeddedBrowser` | string[] | Host patterns for embedded browser |
| `shortcuts.bindings.<actionId>` | string\|string[] | Keybinding |

### Inspect & Validate Config

```bash
# validate syntax
cmux config doctor
cmux config doctor --json

# config paths
cmux config path
cmux settings path
```

### Ghostty Config (Terminal Rendering)

Terminal rendering settings go in `~/.config/ghostty/config`:
- Font, cursor style, theme, scrollback
- `background-opacity` (transparency)
- `background-blur` (blur)

## SSH Workspaces

```bash
# basic
cmux ssh user@host --name "prod"

# with agent forwarding (opt-in for security)
cmux ssh user@host --forward-agent

# with custom identity
cmux ssh user@host --identity ~/.ssh/deploy_key

# with SSH options
cmux ssh user@host --ssh-option "ServerAliveInterval=60"

# with remote command
cmux ssh user@host --name "deploy" -- ./deploy.sh

# list/attach/cleanup persistent SSH sessions
cmux ssh-session-list --json
cmux ssh-session-attach --session-id <uuid>
cmux ssh-session-cleanup --session-id <uuid>
```

## Notifications & Sidebar

### Notifications

```bash
# send notification to a workspace
cmux notify --title "Build" --subtitle "Backend" --body "Tests passed"

# list / mark read / dismiss
cmux list-notifications --json
cmux mark-notification-read --all
cmux dismiss-notification --id <uuid>
cmux open-notification --id <uuid>
cmux jump-to-unread
cmux clear-notifications
```

### Status Pills

```bash
cmux set-status build "running" --color "#ff9500" --icon "hammer"
cmux set-status tests "14/15 passing" --color "#34c759"
cmux clear-status build
cmux list-status --json
```

### Progress Bar

```bash
cmux set-progress 0.0 --label "Starting..."
cmux set-progress 0.5 --label "Building..."
cmux set-progress 1.0 --label "Done"
cmux clear-progress
```

### Log Panel

```bash
cmux log --level info --message "Server started on port 3000"
cmux log --level error --message "Connection refused"
cmux list-log --limit 20 --json
cmux clear-log
```

### Right Sidebar

```bash
cmux right-sidebar toggle
cmux right-sidebar set feed
cmux right-sidebar set files
cmux right-sidebar set find
cmux right-sidebar set vault
cmux right-sidebar mode  # JSON with visible + mode
```

## Markdown Viewer

Open any `.md` file in a formatted panel with live reload:

```bash
cmux markdown open plan.md
cmux markdown open /path/to/PLAN.md --workspace workspace:2
```

The panel auto-updates when the file changes on disk (writes, editor saves,
atomic replacements). Ideal for displaying agent plans, task lists, docs,
or changelogs alongside the terminal.

Supports: headings, code blocks, tables, lists, blockquotes, bold/italic,
links, images, horizontal rules. Works in light and dark mode.

## Agent Hooks & Feed

### Setup / Uninstall

```bash
# install hooks for all found agents
cmux hooks setup

# for a specific agent
cmux hooks setup opencode --project
cmux hooks setup claude
cmux hooks setup codex

# uninstall
cmux hooks uninstall
cmux hooks uninstall --agent opencode
```

### Feed

```bash
# open the Feed TUI
cmux feed tui

# clear persisted feed history
cmux feed clear
```

## Events Stream

Stream reconnectable cmux events as newline-delimited JSON:

```bash
# tail events
cmux events --reconnect

# with cursor-file for resume
cmux events --reconnect --cursor-file /tmp/cmux-cursor.txt

# filter by event name
cmux events --name workspace.focus --name workspace.selection

# limit output
cmux events --limit 10
```

Useful for reacting to workspace focus changes, surface creation/close, etc.

## Launcher Commands

```bash
# launch coding agents in cmux-managed panes
cmux omo [opencode args...]
cmux omx [omx args...]
cmux omc [omc args...]
cmux claude-teams [claude args...]
cmux codex-teams [codex args...]
```

## VM Management

```bash
cmux vm list
cmux vm new --image ubuntu-24.04
cmux vm exec <id> "uname -a"
cmux vm shell <id>
cmux vm rm <id>
```

## Tmux Compatibility

Many tmux command names work (e.g., `capture-pane`, `resize-pane`, `swap-pane`,
`break-pane`, `join-pane`, `next-window`, `last-pane`, `send` → replaces
`send-keys`, etc.). See `cmux help` under "tmux compatibility commands".

## Global Options

| Option | Effect |
|--------|--------|
| `--json` | JSON output for supported commands |
| `--id-format refs\|uuids\|both` | Handle output format |
| `--password <value>` | Socket auth (takes precedence over env) |
| `--window <id\|ref\|index>` | Route to a specific window |

## Socket Access

```bash
cmux capabilities --json   # list all available RPC methods
cmux ping                   # test socket connectivity
cmux socket status          # (if available) check access mode
cmux rpc <method> [params]  # raw v2 socket call
```

## Settings Docs Cheatsheet

```bash
cmux docs settings        # config docs + schema URL
cmux docs api             # CLI contract
cmux docs browser         # browser automation docs
cmux docs agents          # agent hook integration
cmux docs dock            # custom dock controls
cmux docs shortcuts       # keyboard shortcuts
cmux settings path        # config file paths
cmux settings             # open Settings UI
cmux settings shortcuts   # open Settings > Shortcuts
```

## Example: Complete Agent Workflow

```bash
# 1. Identify context
cmux identify --json

# 2. Create a workspace for the task
cmux new-workspace --name "auth-debug" --cwd "$PWD" --focus false

WS="workspace:2"

# 3. Create right helper pane
cmux new-pane --workspace "$WS" --type terminal --direction right --focus false

# 4. Start dev server in helper
cmux send "npm run dev\n"

# 5. Open browser preview
cmux new-pane --workspace "$WS" --type browser --direction right --url "http://localhost:3000" --focus false

# 6. Show progress
cmux set-progress 0.5 --label "Running tests" --workspace "$WS"
cmux set-status test "running" --color "#ff9500" --workspace "$WS"

# 7. Notify when done
cmux notify --title "Auth Debug" --body "Tests completed"

# 8. Clear status
cmux clear-status test --workspace "$WS"
cmux clear-progress --workspace "$WS"
```

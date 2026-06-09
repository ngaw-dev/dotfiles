# cmux Browser Command Reference

## Surface Targeting

All browser commands accept a surface ref as the first positional arg (e.g., `surface:7`).
If omitted from positional, use `--surface <ref>`.

## Commands

| Command | Description |
|---------|-------------|
| `browser open [url]` | Create browser split in caller workspace |
| `browser open-split [url]` | Create browser split |
| `browser goto\|navigate <url>` | Navigate to URL |
| `browser back\|forward\|reload` | History nav / refresh |
| `browser url\|get-url` | Print current URL |
| `browser snapshot [--interactive] [--cursor] [--compact] [--max-depth <n>] [--selector <css>]` | DOM snapshot |
| `browser eval <script>` | Run JS, return result |
| `browser wait [--selector <css>] [--text <text>] [--url-contains <text>] [--load-state <interactive\|complete>] [--function <js>] [--timeout-ms <ms>]` | Wait for condition |
| `browser click\|dblclick\|hover\|focus\|check\|uncheck\|scroll-into-view <selector> [--snapshot-after]` | Element action |
| `browser type <selector> <text> [--snapshot-after]` | Type into input |
| `browser fill <selector> [text] [--snapshot-after]` | Set input value |
| `browser press\|keydown\|keyup <key> [--snapshot-after]` | Keyboard input |
| `browser select <selector> <value> [--snapshot-after]` | Select option |
| `browser scroll [--selector <css>] [--dx <n>] [--dy <n>] [--snapshot-after]` | Scroll page/element |
| `browser screenshot [--out <path>] [--json]` | Save screenshot |
| `browser get <url\|title\|text\|html\|value\|attr\|count\|box\|styles>` | Read page state |
| `browser is <visible\|enabled\|checked> <selector>` | Boolean state check |
| `browser find <role\|text\|label\|placeholder\|alt\|title\|testid\|first\|last\|nth>` | Find elements |
| `browser frame <selector\|main>` | Select iframe context |
| `browser dialog <accept\|dismiss> [text]` | Handle dialog |
| `browser download [wait] [--path <path>] [--timeout-ms <ms>]` | Handle download |
| `browser profiles <list\|add\|rename\|clear\|delete>` | Manage browser profiles |
| `browser import [--from <browser>] [--profile <name>] [--all-profiles] [--to-profile <name>] [--create-profile <name>] [--domain <domain>]` | Import cookies |
| `browser cookies <get\|set\|clear>` | Cookie management |
| `browser storage <local\|session> <get\|set\|clear>` | Storage management |
| `browser tab <new\|list\|switch\|close\|<index>>` | Tab management |
| `browser console <list\|clear>` | Console messages |
| `browser errors <list\|clear>` | Error messages |
| `browser highlight <selector>` | Visual element highlight |
| `browser state <save\|load> <path>` | Save/load browser state |
| `browser addinitscript <script>` | Inject script on navigation |
| `browser addscript <script>` | Inject script immediately |
| `browser addstyle <css>` | Inject CSS |
| `browser identify [--surface <ref>]` | Identify browser context |

## Selector Types

- **Ref** — snapshot element refs: `e1`, `e2`, etc. (from `snapshot --interactive`)
- **CSS selector** — standard CSS: `"#submit"`, `".btn.primary"`, `"input[name='email']"`
- **text=** — text-based: `text="Submit"`, `text=/Sign up/i`
- **xpath=** — XPath: `xpath=//button[text()='Submit']`

## Snapshot Ref Lifecycle

- Refs are per-snapshot. A new snapshot invalidates old refs.
- Always re-snapshot after navigation or major DOM changes.
- `--snapshot-after` on action commands generates a fresh snapshot automatically.

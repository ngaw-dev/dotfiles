# Neovim Keymaps

This configuration uses `<Space>` as the Leader key.

## General

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<C-s>` | n, i, v | Save file |
| `<Esc>` | n, i | Clear search highlighting |
| `<Leader>l` | n | Lazy (Plugin Manager) |

## Window Management

| Key | Description |
| :--- | :--- |
| `<C-h>` | Go to left window |
| `<C-j>` | Go to lower window |
| `<C-k>` | Go to upper window |
| `<C-l>` | Go to right window |
| `<C-Up>` | Increase window height |
| `<C-Down>` | Decrease window height |
| `<C-Left>` | Decrease window width |
| `<C-Right>` | Increase window width |

## Editing

| Key | Mode | Description |
| :--- | :--- | :--- |
| `<A-j>` | n, i, v | Move line/selection down |
| `<A-k>` | n, i, v | Move line/selection up |

## Telescope (Fuzzy Finder)

| Key | Description |
| :--- | :--- |
| `<Leader><Space>` | Find files (root dir) |
| `<Leader>/` | Live grep (search text in files) |
| `<Leader>,` | Switch buffers |
| `<Leader>:` | Command history |
| `<Leader>ff` | Find files |
| `<Leader>fg` | Find git files |
| `<Leader>fr` | Recent files |
| `<Leader>fb` | Buffers |
| `<Leader>gc` | Git commits |
| `<Leader>gs` | Git status |

### Telescope Navigation (Insert Mode)
| Key | Description |
| :--- | :--- |
| `<C-j>` | Move selection next |
| `<C-k>` | Move selection previous |
| `<C-t>` | Open selection in new tab |

## Treesitter (Syntax)

| Key | Description |
| :--- | :--- |
| `<C-Space>` | Increment selection |
| `<BS>` | Decrement selection |

## Completion (Insert Mode)

| Key | Description |
| :--- | :--- |
| `<C-n>` | Select next item |
| `<C-p>` | Select previous item |
| `<C-b>` | Scroll docs back |
| `<C-f>` | Scroll docs forward |
| `<C-Space>` | Trigger completion |
| `<CR>` | Confirm selection |
| `<Tab>` | Jump to next snippet placeholder |
| `<S-Tab>` | Jump to previous snippet placeholder |

# Dotfiles

Configuration files for my macOS development environment.

## Overview

This repository contains dotfiles and configurations for:

- **Shell**: Zsh with Zinit
- **Prompt**: Starship
- **Version Control**: Git
- **Tools**: FZF, Zoxide

## Prerequisites

Before installing, ensure you have the following installed on your machine:

1.  **Homebrew** (Package Manager)

    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2.  **Core Packages**

    ```bash
    brew install git zsh starship zoxide fzf stow fd bat eza ripgrep
    brew install --cask warp
    brew install --cask brave-browser
    brew install --cask 1password
    brew install --cask arc
    brew install php@8.3 composer caddy node@22 pnpm
    brew install --cask orbstack
    brew install --cask sequel-ace
    brew install ddev/ddev/ddev
    brew install --cask font-caskaydia-cove-nerd-font
    brew install markdownlint-cli pv
    curl -O "https://cdn.bigmodel.cn/install/claude_code_zai_env.sh" && bash ./claude_code_zai_env.sh
    curl -fsSL https://opencode.ai/install | bash
    brew install 1password-cli
    ```

3.  **Zinit**

    Zinit installs itself and its plugins automatically on first shell launch (requires network access). To pre-install it manually:

    ```bash
    git clone --depth 1 https://github.com/zdharma-continuum/zinit.git ~/.local/share/zinit/zinit.git
    ```

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/ngaw-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install with Stow

Use GNU Stow to create symlinks for your configurations.

```bash
# Install all dotfiles
stow aliases bash fzf git herdr starship zsh bat pnpm opencode atuin
```

**Note:** Stow will symlink files to your `$HOME` directory by default. If you have existing configuration files, you may need to back them up or delete them before running stow, or use the `--adopt` flag to overwrite them with your dotfiles versions (be careful, this modifies the source files in your repo).

```bash
# Example: Adopt existing files into the repo
stow --adopt zsh
git restore . # Discard changes if you didn't mean to keep the system version
```

## Post-Installation

1.  **Reload Zsh**

    ```bash
    source ~/.zshrc
    ```

## Directory Structure

The repository is structured as Stow packages:

- `aliases/` -> `~/.aliases`
- `atuin/` -> `~/.config/atuin/config.toml`
- `bash/` -> `~/.bashrc`
- `bat/` -> `~/.config/bat/config`
- `fzf/` -> `~/.fzf.zsh`
- `git/` -> `~/.gitconfig`
- `herdr/` -> `~/.config/herdr/`
- `pnpm/` -> `~/Library/Preferences/pnpm/rc`
- `starship/` -> `~/.config/starship.toml`
- `zsh/` -> `~/.zshrc` & `~/.paths`

## Environment Variables

Secrets are stored in a root `.env` file (not tracked by git). Copy the example and fill in your values:

```bash
cp .env.example .env
```

| Variable      | Description                                   |
| ------------- | --------------------------------------------- |
| `OP_VAULT_ID` | 1Password vault ID for API credential storage |
| `GH_TOKEN`    | GitHub personal access token                  |

The `.env` file is automatically sourced by `.zshrc` on shell startup.

## 1Password

- Create API credentials using `./scripts/op-create`
- Reveal a secret: `op item get "gh-token" --field credential --reveal`

## Herdr Plugins installed
- https://github.com/qu8n/herdr-automatic-rename
  `curl -fsSL https://raw.githubusercontent.com/qu8n/herdr-automatic-rename/main/install.sh | bash`
- https://github.com/thanhdat77/herdr-navigator
  `herdr plugin install thanhdat77/herdr-navigator --ref v0.3.3 --yes`
  `herdr plugin action invoke herdr-navigator.open`
  `herdr plugin action invoke herdr-automatic-rename.reset`
- `herdr integration install opencode`

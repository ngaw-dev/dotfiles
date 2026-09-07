# Dotfiles

Configuration files for my macOS development environment.

## Overview

This repository contains dotfiles and configurations for:

- **Shell**: Zsh with Zinit
- **Prompt**: Starship
- **Editor**: Neovim
- **Terminal**: Kitty
- **Multiplexer**: Tmux
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
    brew install git zsh neovim tmux kitty starship zoxide fzf stow fd bat eza ripgrep jq
    brew install --cask warp
    brew install --cask brave-browser
    brew install --cask 1password
    brew install --cask arc
    brew install php@8.3 composer caddy node@22 pnpm
    brew install --cask orbstack
    brew install --cask sequel-ace
    brew install --cask antigravity
    brew install ddev/ddev/ddev
    brew install --cask font-caskaydia-cove-nerd-font
    curl -O "https://cdn.bigmodel.cn/install/claude_code_zai_env.sh" && bash ./claude_code_zai_env.sh
    ```

3.  **Zinit**

    Zinit is bootstrapped automatically the first time you source `~/.zshrc` (it self-clones to `~/.local/share/zinit/zinit.git` if missing). No manual install step needed — plugins (`zsh-autosuggestions`, `zsh-syntax-highlighting`, and the Oh My Zsh `git` plugin snippet) are declared in `zsh/.zshrc` and installed on first run.

4.  **Atuin** ([atuin.sh](https://atuin.sh)) — shell history sync/search
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf https://setup.atuin.sh | sh
    ```

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install with Stow

Use GNU Stow to create symlinks for your configurations.

```bash
# Install all dotfiles
stow aliases atuin bash fzf git herdr kitty nvim starship tmux zsh bat
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

2.  **Install Tmux Plugin Manager (TPM)**
    ```bash
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    # Press Ctrl b + I in tmux to install plugins
    ```

## Directory Structure

The repository is structured as Stow packages:

- `aliases/` -> `~/.aliases`
- `atuin/` -> `~/.config/atuin/config.toml`
- `bat/` -> `~/.bat.conf` 
- `bash/` -> `~/.bashrc`
- `fzf/` -> `~/.fzf.zsh`
- `git/` -> `~/.gitconfig`
- `kitty/` -> `~/.config/kitty/`
- `nvim/` -> `~/.config/nvim/`
- `starship/` -> `~/.config/starship.toml`
- `tmux/` -> `~/.tmux.conf` & `~/.config/tmux/`
- `zsh/` -> `~/.zshrc` & `~/.paths`

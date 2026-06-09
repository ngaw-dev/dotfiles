# Dotfiles

Configuration files for my macOS development environment.

## Overview

This repository contains dotfiles and configurations for:

- **Shell**: Zsh with Oh My Zsh
- **Prompt**: Starship
- **Editor**: Neovim
- **Terminal**: Kitty, Ghostty, Cmux
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
    brew install git zsh neovim tmux kitty starship zoxide fzf stow fd bat eza ripgrep ghostty
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
    ```

3.  **Oh My Zsh**

    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

4.  **Zsh Plugins**
    ```bash
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
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
stow aliases bash fzf git kitty ghostty nvim starship tmux zsh bat pnpm cmux opencode
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
- `bash/` -> `~/.bashrc`
- `bat/` -> `~/.config/bat/config`
- `fzf/` -> `~/.fzf.zsh`
- `git/` -> `~/.gitconfig`
- `ghostty/` -> `~/.config/ghostty/`
- `kitty/` -> `~/.config/kitty/`
- `cmux/` -> `~/.config/cmux/`
- `nvim/` -> `~/.config/nvim/`
- `pnpm/` -> `~/Library/Preferences/pnpm/rc`
- `starship/` -> `~/.config/starship.toml`
- `tmux/` -> `~/.tmux.conf` & `~/.config/tmux/`
- `zsh/` -> `~/.zshrc` & `~/.paths`

## Getting folders configuration

- Run `pnpm config get globalconfig` to get pnpm config file location if required.

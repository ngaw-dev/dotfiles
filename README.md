# Dotfiles

Configuration files for my macOS development environment.

## Overview

This repository contains dotfiles and configurations for:

- **Shell**: Zsh with Oh My Zsh
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
    brew install git zsh neovim tmux kitty starship zoxide fzf stow
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
stow aliases bash fzf git kitty nvim starship tmux zsh
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
- `fzf/` -> `~/.fzf.zsh`
- `git/` -> `~/.gitconfig`
- `kitty/` -> `~/.config/kitty/`
- `nvim/` -> `~/.config/nvim/`
- `starship/` -> `~/.config/starship.toml`
- `tmux/` -> `~/.tmux.conf` & `~/.config/tmux/`
- `zsh/` -> `~/.zshrc` & `~/.paths`

# Dotfiles (Server Branch)

Configuration files for my Ubuntu Server environment.

## Overview

This repository branch contains dotfiles and configurations for:

- **Shell**: Zsh with Oh My Zsh
- **Editor**: Neovim
- **Version Control**: Git
- **History & Tools**: Atuin, Bat, FZF, Zoxide

## Prerequisites

Before installing, ensure you have the following installed on your machine:

1. **Core Packages**
   ```bash
   sudo apt update
   sudo apt install -y git zsh curl build-essential stow bat fzf
   ```

2. **Oh My Zsh**
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. **Zsh Plugins**
   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   ```

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/ngaw-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles
git checkout server
```

### 2. Install with Stow

Use GNU Stow to create symlinks for your configurations:

```bash
stow aliases atuin bat fzf git nvim zsh
```

**Note:** If you have existing configuration files, run `stow --adopt <package>` or back them up.

## Directory Structure

The repository is structured as Stow packages:

- `aliases/` -> `~/.aliases`
- `atuin/` -> `~/.config/atuin/config.toml`
- `bat/` -> `~/.config/bat/config`
- `fzf/` -> `~/.fzf.zsh`
- `git/` -> `~/.gitconfig`
- `nvim/` -> `~/.config/nvim/`
- `zsh/` -> `~/.zshrc` & `~/.paths`


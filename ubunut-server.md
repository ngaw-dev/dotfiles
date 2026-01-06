# Fail2Ban Setup
```bash
sudo apt update
sudo apt install fail2ban -y
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
```

Configure the sshd jail to be aggressive against port scanning:
```ini
[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
maxretry = 3        # Ban after 3 failed attempts
bantime = 3600      # Ban for 1 hour
findtime = 600      # If 3 failures occur within 10 minutes
```

```bash
sudo systemctl restart fail2ban
```

# User Setup
```bash
adduser amolw
usermod -aG sudo amolw
```

# Install Dependencies
```bash
# Basic packages
sudo apt update
sudo apt install -y git curl build-essential

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install starship prompt
curl -Lo /tmp/starship.tar.gz https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz
tar xzf /tmp/starship.tar.gz -C /tmp/
mv /tmp/starship ~/.local/bin/starship
chmod +x ~/.local/bin/starship

# Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# Install other tools via Homebrew (optional)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install neovim tmux fzf fd bat eza
brew install php@8.3 composer node@22 pnpm
```

# Dotfiles Setup
```bash
# Clone dotfiles
git clone git@github.com:ngaw-dev/dotfiles.git ~/dotfiles
cd ~/dotfiles
git checkout server

# Use stow to symlink configs
stow aliases bash fzf git nvim starship tmux zsh

# If you need to adopt existing configs
stow --adopt zsh
git restore .
```

# Reload Shell
```bash
source ~/.zshrc
```

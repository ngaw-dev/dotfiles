# Fail2Ban
```
sudo apt update
sudo apt install fail2ban -y

```
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

```
sudo nano /etc/fail2ban/jail.local
```4. Configure the "port scanning" detector (sshd):
While Fail2ban doesn't strictly "ban port scanning" by default (it usually bans failed logins), you can adjust the ssh jail to be very aggressive.
Find the sshd section and make it look like this:
```
[sshd]
enabled = true
port    = ssh
logpath = %(sshd_log)s
maxretry = 3        # Ban after 3 failed attempts
bantime = 3600      # Ban for 1 hour
findtime = 600      # If 3 failures occur within 10 minutes
```

```
sudo systemctl restart fail2ban
```

# Packages install

```
adduser amolw
usermod -aG sudo ubuntu

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 

echo >> /home/amolw/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/amolw/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install git zsh neovim tmux starship zoxide fzf stow fd bat eza
brew install php@8.3 composer node@22 pnpm
curl -O "https://cdn.bigmodel.cn/install/claude_code_zai_env.sh" && bash ./claude_code_zai_env.sh
```

# Dotfiles
git clone git@github.com:ngaw-dev/dotfiles.git
git checkout server
```
stow aliases bash fzf git nvim starship tmux zsh
stow --adopt zsh
git restore .
```

#!/bin/sh

# Upgrade all packages installed on the system.
sudo apt update -y
sudo apt upgrade -y

# Install extra packages.
sudo apt install -y \
    curl \
    docker.io \
    emacs \
    fish \
    fonts-hack \
    git \
    make \
    pass \
    pwgen \
    restic \
    stow \
    tmux \
    tomb \
    tree \
    whois \
    xkcdpass

# Enable the firewall.
sudo ufw enable

# Avoid using sudo when running docker.
sudo usermod -aG docker $USER

# Configure GNOME Shell.
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false

# Configure GNOME Terminal.
GNOME_TERMINAL_PROFILE=`gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}'`
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ cursor-blink-mode 'off'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ font 'Hack 12'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy 'never'
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-system-font false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-colors false
gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-transparency false

# Install dotfiles and dependencies.
git clone https://github.com/stevenharford/dotfiles.git ~/dotfiles
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
cd ~/dotfiles
stow -t ~ --no-folding emacs fish git gnupg tmux
cd ~

# Change the default shell.
chsh -s /usr/bin/fish

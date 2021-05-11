FROM ubuntu:20.04

# Make the container instances more comfortable to use.
RUN yes | unminimize

# Install extra packages.
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl \
    emacs \
    fish \
    fonts-hack \
    git \
    gnome-terminal \
    locales-all \
    python3 \
    python3-dev \
    python3-pip \
    python3-venv \
    pipenv \
    stow \
    tmux \
    tree \
    && rm -rf /var/lib/apt/lists/*

# Set up the locale and timezone.
ENV LANG=en_IE.UTF-8
ENV LANGUAGE=en_IE:en
ENV TZ=Europe/Dublin

# Set up the user and default shell.
RUN useradd -c "Steven Harford" -m -u 1000 -o -s /usr/bin/fish stevenharford
USER stevenharford:stevenharford
WORKDIR /home/stevenharford

# Install dotfiles and dependencies.
RUN git clone https://github.com/stevenharford/dotfiles.git ~/dotfiles
RUN git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
RUN cd ~/dotfiles && stow -t ~ --no-folding emacs fish git tmux

# Install Emacs and fish packages.
RUN emacs -Q --batch -l ~/.emacs.d/init.el --eval "(all-the-icons-install-fonts t)"
RUN TERM=xterm-256color fish -i ~/.config/fish/config.fish

# Configure GNOME Terminal.
RUN GNOME_TERMINAL_PROFILE=`gsettings get org.gnome.Terminal.ProfilesList default | awk -F \' '{print $2}'` \
    && dbus-launch gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false \
    && dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ cursor-blink-mode 'off' \
    && dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ font 'Hack 12' \
    && dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ scrollbar-policy 'never' \
    && dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-system-font false \
    && dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-colors false \
    && dbus-launch gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$GNOME_TERMINAL_PROFILE/ use-theme-transparency false

# Ignore warnings not applicable to me.
ENV NO_AT_BRIDGE=1

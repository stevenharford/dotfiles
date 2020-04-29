if status --is-interactive
    # Set the default text editor. I really, really like Emacs!
    set --export EDITOR '/usr/bin/emacs -nw'

    # Configure GnuPG.
    set --export GPG_TTY (tty)

    # Make Base16 Shell colour themes easy to use.
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"

    # Ensure a colour theme is set.
    if not test -e ~/.base16_theme
        base16-gruvbox-dark-medium
    end

    # Automate the installation of Fisher (and any packages listed in
    # the fishfile) on a new system.
    if not functions -q fisher
        set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
        curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
        fish -c fisher
    end
end

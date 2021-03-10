if status --is-interactive
    # Set the default text editor. I really, really like Emacs!
    set --export EDITOR '/usr/bin/emacs -nw'

    # Configure GnuPG.
    set --export GPG_TTY (tty)

    # Configure pass.
    set --export PASSWORD_STORE_DIR "$HOME/passwords"

    # Make Base16 Shell colour themes easy to use.
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"

    # Ensure a colour theme is set.
    if not test -e ~/.base16_theme
        base16-gruvbox-dark-medium
    end

    # Automate the installation of Fisher (and any packages listed in
    # fish_plugins) on a new system.
    if not functions -q fisher
        curl -sL https://git.io/fisher | source
        fisher update
    end
end

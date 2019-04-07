if status --is-interactive
    # Prepend my private bin to the path variable.
    set --global --export PATH $HOME/projects/bin $PATH

    # Set the default text editor. I really, really like Emacs!
    set --export EDITOR /usr/bin/emacs -nw

    # Configure GnuPG.
    set --export GPG_TTY (tty)

    # Configure pass.
    set --export PASSWORD_STORE_DIR $HOME/organizer/passwords

    # Handy shortcuts for running Emacs in a terminal and in a GUI
    # (via Crostini on a Chromebook).
    abbr --add --global te emacs -nw
    abbr --add --global ge sommelier -X --scale=0.9 --dpi=120 emacs

    # Set default shell colours via Base16 Shell.
    eval sh $HOME/.config/base16-shell/scripts/base16-gruvbox-dark-medium.sh
end

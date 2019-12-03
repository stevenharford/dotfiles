if status --is-interactive
    # Prepend my private bin to the path variable.
    set --global --export PATH $HOME/projects/bin $PATH

    # Set the default text editor. I really, really like Emacs!
    set --export EDITOR '/usr/bin/emacs -nw'

    # Configure GnuPG.
    set --export GPG_TTY (tty)

    # Configure pass.
    set --export PASSWORD_STORE_DIR $HOME/organizer/passwords

    # Set default shell colours via Base16 Shell.
    eval sh $HOME/.config/base16-shell/scripts/base16-gruvbox-dark-medium.sh

    # Ensure Fisher and packages listed in my fishfile are installed
    # (https://github.com/jorgebucaran/fisher#bootstrap-installation).
    if not functions -q fisher
        set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
        curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
        fish -c fisher
    end
end

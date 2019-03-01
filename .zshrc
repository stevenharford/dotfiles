# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/stevenharford/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Make life a little easier with antigen.
source ~/.config/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme frisk

antigen apply

# Handy shortcuts for running Emacs in a terminal and in a GUI.
alias temacs='emacs -nw'
gemacs () { sommelier -X --scale=0.9 --dpi=120 emacs "$@"& }

# Conveniently change colour themes via Base16 Shell.
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Set default shell colours.
if [[ ! -L ~/.base16_theme ]]; then
    base16_gruvbox-dark-medium
fi

# Configure GnuPG.
export GPG_TTY=$(tty)

# Set the default editor - I really, really like Emacs!
export EDITOR="/usr/bin/emacs -nw"

# Configure pass.
export PASSWORD_STORE_DIR="$HOME/organizer/passwords"

# Prepend my private bin to the path variable.
export "PATH=$HOME/projects/bin:$PATH"

# Load nvm and its bash completions only when needed. This
# significantly speeds up shell load times.
load_nvm () {
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

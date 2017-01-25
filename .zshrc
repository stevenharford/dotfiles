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

# A handy shortcut for running Emacs in the current terminal window.
alias te='emacs -nw'

# Ensure gruvbox looks as it should in Emacs on the terminal.
source ~/.config/gruvbox/gruvbox_256palette.sh

# Make life a little easier with antigen.
source ~/.config/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme robbyrussell

export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

antigen apply

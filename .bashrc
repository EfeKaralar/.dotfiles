#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Custom exports
export BROWSER=firefox
export TERMINAL=st
export EDITOR=vim
export PATH=$PATH:~/.dotfiles/voidrice/.local/bin/statusbar
export LOCATION=sce
# Custom aliases
alias p='sudo pacman'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

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
# ANDROID THINGS
export ANDROID_HOME=/home/alp/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANROID_HOME/emulator

# Custom aliases
alias p='sudo pacman'

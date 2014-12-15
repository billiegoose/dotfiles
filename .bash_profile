#!/bin/bash
# ~/.bash_profile - by William Hilton

# Assuming this is an Ubuntu System, the defaults are in .profile
# (which in turn calls .bashrc)
. "$HOME/.profile"

# I like to just git clone things into ~/bin, so I like to add
# all the binaries inside those repos to the PATH.
for d in ~/bin/*/bin; do PATH="$PATH:$d"; done

# VIM yeah.
export EDITOR=vim

# Ubuntu aliases grep, ls, to the color-enabled versions... but not less?
alias less='less -r'

# So fun fact. Ctrl+S freezes all terminal input and Ctrl+Q resumes input.
# There is NO WAY that feature is ever useful. So turn it off so we can use
# Ctrl+S to save in Vim
stty -ixon

# Automatically start tmux! (essentially replaces Bash as the default login s
# http://stackoverflow.com/a/22821040/2168416
tmux -2 attach &> /dev/null
if [[ ! $TERM =~ screen ]]; then
  exec tmux -2
fi

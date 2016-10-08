#!/bin/bash
# ~/.bash_profile - by William Hilton

# Assuming this is an Ubuntu System, the defaults are in .profile
# (which in turn calls .bashrc)
. "$HOME/.profile"

# Override prompt that .bashrc provides with a better one
PS1='\D{%a %T} \u@\h:\w\n\$ '

# I like to just git clone things into ~/bin, so I like to add
# all the binaries inside those repos to the PATH.
for d in ~/bin/*/bin; do PATH="$PATH:$d"; done

# Search for optional packages to source
[ -d ~/bin/oh-my-git ] && source ~/bin/oh-my-git/prompt.sh
[ -d ~/bin/git-subrepo ] && source ~/bin/git-subrepo/.rc
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Put shim install_basics.sh at end of PATH
PATH="$PATH:$HOME/.install_basics"

# Textadept is the shit!
export EDITOR=ta

# Ubuntu aliases grep, ls, to the color-enabled versions... but not less?
export LESS='-RFX'

# So fun fact. Ctrl+S freezes all terminal input and Ctrl+Q resumes input.
# There is NO WAY that feature is ever useful. So turn it off so we can use
# Ctrl+S to save in Vim
stty -ixon

# Automatically start tmux! (essentially replaces Bash as the default login shell)
# This is a very delicate operation.
# 1) tmux command exists 2) this is an interactive shell 3) we are not inside tmux screen 4) we're definitely not inside tmux 5) replace this process with tmux (start or join session 'default')
command -v tmux > /dev/null && [[ $- == *i* ]] && [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux new-session -A -s default

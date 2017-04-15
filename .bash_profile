#!/bin/bash
# ~/.bash_profile - by William Hilton

# Ubuntu does some nonsense with .bash_profile loading .profile which sees if
# the term is bash and if so loads .bashrc.
# I guarantee if I'm loading .bash_profile, I want to load .bashrc if it exists
# On Bash for Windows, it appears it loads .bashrc first.
# Anyway, we need to make sure THIS file doesn't run recursively.
if [ "$IFDEF_BASH_PROFILE" == 'TRUE' ]; then
  unset IFDEF_BASH_PROFILE
  return
fi
export IFDEF_BASH_PROFILE='TRUE'
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# I like to just git clone things into ~/bin, so I like to add
# all the binaries inside those repos to the PATH.
for d in ~/bin/*/bin; do PATH="$PATH:$d"; done

# Search for optional packages to source
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

# Override prompt that .bashrc provides with a better one
# Here is a "dumb" better one (sets PS1 to a more useful string)
# PS1='\D{%Y-%m-%d %H:%M:%S} \u@\h \w\n\$ '
# Here is a "fancy" better one (abuses the shit out of PROMPT_COMMAND to do magic)
PS1=''
source ~/.mightyprompt
# Add my git prompt
source ~/.oh-my-git/prompt.sh
function uber_prompt() {
  MIGHTY_PROMPT="$(mighty_prompt) ($(git rev-parse --abbrev-ref HEAD 2>/dev/null))"
  PS1="${MIGHTY_PROMPT}\n> "
  #build_prompt & disown
  unset timer_start
}
PROMPT_COMMAND="uber_prompt"

# Update window title to be the original working directory
if which ConEmuC &>/dev/null; then
  ConEmuC -GuiMacro Rename 0 "$(basename $(pwd))" >/dev/null
fi

# Automatically start tmux! (essentially replaces Bash as the default login shell)
# This is a very delicate operation.
# 1) tmux command exists 2) this is an interactive shell 3) we are not inside tmux screen 4) we're definitely not inside tmux 5) replace this process with tmux (start or join session 'default')
command -v tmux > /dev/null && [[ $- == *i* ]] && [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux new-session -A -s default

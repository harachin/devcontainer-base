# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Set environment variables
export EDITOR=vim
export PAGER=less

# Set bash prompt
source ~/.git-completion.bash
source ~/.git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

PS1="\[\e[1;32m\]\u:\[\e[1;34m\]\W\[\e[m\]\[\e[33m\]\$(__git_ps1)\[\e[m\]\$ "

# Set history options
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend

# Load user-specific aliases and functions if available
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

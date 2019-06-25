# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# eternal command history
HISTSIZE=
HISTFILESIZE=
HISTFILE=~/.bash_eternal_history

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# bash completion on OSX (with Homebrew)
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# fix tmux ssh sessions
SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

# nvm for multiple versions of nodejs
test -a ~/nvm/nvm.sh &&
    . ~/nvm/nvm.sh

# add yarn global bin folder to path
YARN_BIN=$(yarn global bin)
if [ -d $YARN_BIN ]; then
    PATH=$PATH:$YARN_BIN
fi

# http://henrik.nyh.se/2008/12/git-dirty-prompt
# http://www.simplisticcomplexity.com/2008/03/13/show-your-git-branch-name-in-your-prompt/
#   username@Machine ~/dev/dir[master]$   # clean working directory
#   username@Machine ~/dev/dir[master*]$  # dirty working directory
function parse_git_dirty {
  [[ $(git status -z) != "" ]] && echo "*"
}
function parse_git_branch {
    [[ $(git rev-parse --git-dir 2> /dev/null) != "" ]] &&
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
export PS1='\u@\h/\W$(parse_git_branch)$ '

# user directory path
PATH=$PATH:$HOME/bin

# use vim if available
[ command -v vim >/dev/null 2>&1 ] &&
    export EDITOR=vim

# golang
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
PATH=$PATH:$GOPATH/bin
# export GO15VENDOREXPERIMENT=1

# docker
alias docker-rmi-all='docker images --quiet --all | xargs docker rmi --force'
alias docker-rm-all='docker ps --quiet --all | xargs docker rm --force'
alias docker-clear='docker-rm-all && docker-rmi-all'
#docker-machine start default >/dev/null
#eval "$(docker-machine env default)"
#dmenv () {
#    if [ -z "$1" ]
#    then
#        return
#    fi
#    eval "$(docker-machine env $1)"
#    echo "docker-machine env for $1 set"
#}

# load local environment if available
[ -f ~/.bash_local ] &&
    . ~/.bash_local

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# ruby junk
export PATH="/Users/jordan/.rbenv/shims:${PATH}"
export RBENV_SHELL=bash
[ -f /usr/local/Cellar/rbenv/1.0.0/libexec/../completions/rbenv.bash ] &&
    . /usr/local/Cellar/rbenv/1.0.0/libexec/../completions/rbenv.bash
command rbenv rehash 2>/dev/null
rbenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}

# python junk
PATH="$PATH:$HOME/Library/Python/2.7/bin"

# why homebrew why
export HOMEBREW_GITHUB_API_TOKEN="e117886c47229132f35cf59c31a4076f3d84251d"

# aws env
if [ -f ~/.aws/env.bash ]; then
    . ~/.aws/env.bash
fi

#pkg-config wat
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig

# nvm ugh
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

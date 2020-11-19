# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#
# Shell
#

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

# user directory path
PATH=$PATH:$HOME/bin

#
# Prompt
#

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  color_prompt=yes
else
  color_prompt=
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

# show git status in prompt
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

#
# Aliases
#

# some more ls aliases
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#
# Tools
#

# fix tmux ssh sessions
SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

# default editor is neovim, fallback to vim
[ command -v vim >/dev/null 2>&1 ] &&
    export EDITOR=vim
[ command -v nvim >/dev/null 2>&1 ] &&
    export EDITOR=nvim

# docker
alias docker-rmi-all='docker images --quiet --all | xargs docker rmi --force'
alias docker-rm-all='docker ps --quiet --all | xargs docker rm --force'
alias docker-clear='docker-rm-all && docker-rmi-all'

# why homebrew why
export HOMEBREW_GITHUB_API_TOKEN="e117886c47229132f35cf59c31a4076f3d84251d"
export PATH="/usr/local/opt/terraform@0.11/bin:$PATH"
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

#
# Programming Languages
#

# pkg-config wat
# Not sure why I need this, but I'm afraid to remove it.
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig

# golang
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
PATH=$PATH:$GOPATH/bin

# python
# use python installed in home dir
PATH="$PATH:$HOME/Library/Python/2.7/bin"

# nodejs
# use nvm installed by homebrew
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
# add yarn global bin folder to path
YARN_BIN=$(yarn global bin)
if [ -d $YARN_BIN ]; then
    PATH=$PATH:$YARN_BIN
fi

# need the Android SDK in the PATH to support Expo
# [ -d /Users/jordanacosta/Library/Android/sdk ] &&
#   PATH=$PATH:/Users/jordanacosta/Library/Android/sdk
[ -d /Users/jordanacosta/Library/Android/sdk/platform-tools ] &&
  PATH=$PATH:/Users/jordanacosta/Library/Android/sdk/platform-tools

#
# Optional local env
#

[ -f ~/.bash_local ] &&
    . ~/.bash_local


# need the Android SDK in the PATH to support Expo
# [ -d /Users/jordanacosta/Library/Android/sdk ] &&
#   PATH=$PATH:/Users/jordanacosta/Library/Android/sdk
[ -d /Users/jordanacosta/Library/Android/sdk/platform-tools ] &&
  PATH=$PATH:/Users/jordanacosta/Library/Android/sdk/platform-tools

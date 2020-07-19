# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#
# zsh options
#

# enable completion
autoload -Uz compinit && compinit

# customize prompt
autoload -Uz promptinit && promptinit
prompt adam2

# enable vi command mode
bindkey -v

# vi does not allow backspacing to delete characters that were already there before entering input mode
# this will allow backspaceing like vim
bindkey -v '^?' backward-delete-char

# Correctly display UTF-8 with combining characters.
if [[ "$(locale LC_CTYPE)" == "UTF-8" ]]; then
    setopt COMBINING_CHARS
fi

#
# zsh configure history
#

# Save command history
HISTFILE=$HOME/.zsh_history

# unlimited command history
HISTSIZE=1000000
SAVEHIST=1000000

#
# general environment customization
#

# user directory path
PATH=$PATH:$HOME/bin

# ls colors and aliases
alias ls='ls -G'
alias ll='ls -AlF'
alias la='ls -A'
alias l='ls -CF'

# grep colors and aliases
alias grep='grep --color'
alias fgrep='fgrep --color'
alias egrep='egrep --color'
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

#
# Programming Languages
#

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

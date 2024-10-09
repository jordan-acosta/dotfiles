# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#
# zsh options
#

# homebrew completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# enable completion
autoload -Uz compinit && compinit

# git info in right prompt
autoload -Uz vcs_info && vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%{%F{green}%B%}●%{%b%f%}'
zstyle ':vcs_info:*' unstagedstr '%{%F{red}%B%}●%{%b%f%}'
zstyle ':vcs_info:*' formats '%c %u %F{cyan}%r/%b%f'
zstyle ':vcs_info:*' actionformats '%F{red}%a%f %c %u %F{cyan}%r/%b%f'

# customize prompt
autoload -Uz promptinit && promptinit
# prompt adam2
PROMPT='%(?.%F{green}.%F{red})%?%f %B%F{cyan}%~%f%b %# '

# enable vi command mode
bindkey -v

# vi does not allow backspacing to delete characters that were already there before entering input mode
# this will allow backspaceing like vim
bindkey -v '^?' backward-delete-char

# vi disables the Ctrl+R history keybinding. Need to re-enable it.
bindkey "^R" history-incremental-search-backward

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
alias ls='ls -G --color'
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

# add homebrew install path
PATH=/opt/homebrew/bin:$PATH

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

[ -f ~/.zsh_local ] &&
    . ~/.zsh_local

# javascript / typescript
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# golang
PATH="$PATH:$HOME/go/bin"

# make sure gpg works
export GPG_TTY=$(tty)

# WarpStream
export PATH="/Users/jordanacosta/.warpstream:$PATH"

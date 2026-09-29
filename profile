[ -r ~/.bashrc ] && . ~/.bashrc
[ -r "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

[ -r "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jordanacosta/.lmstudio/bin"

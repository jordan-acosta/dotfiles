# just load the zhsrc
[ -r ~/.zshrc ] && . ~/.zshrc

# homebrew setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# node homebrew setup
export HOMEBREW_GITHUB_API_TOKEN="e117886c47229132f35cf59c31a4076f3d84251d"
export PATH="/usr/local/opt/terraform@0.11/bin:$PATH"
export PATH="/opt/homebrew/opt/node@14/bin:$PATH"

# nvm homebrew setup
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

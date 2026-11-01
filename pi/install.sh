#!/bin/bash
###
# Symlinks pi extensions and agents into ~/.pi/agent.
# Only links the entries below; ~/.pi/agent also holds sessions and auth,
# which must stay out of this repo.
###

set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/agent"
target=~/.pi/agent
backup=~/dotfiles-backup/pi

links="extensions/subagent agents/coder.md"

for link in $links; do
	mkdir -p "$(dirname "$target/$link")"
	if [ -e "$target/$link" ] && [ ! -L "$target/$link" ]; then
		echo "Moving $target/$link to $backup"
		mkdir -p "$(dirname "$backup/$link")"
		mv "$target/$link" "$backup/$link"
	fi
	ln -sfn "$dir/$link" "$target/$link"
	echo "Linked $target/$link"
done

#!/bin/bash
###
# .make.sh
# Creates symlinks in ~ for dotfiles.
# Creates symlinks in ~/.config for config files.
###

dir=~/dotfiles

# link dotfiles
backup=~/dotfiles-backup
files="config vimrc gitconfig bashrc profile tmux.conf yarnrc"

echo "Creating $backup for backup of any existing dotfiles in ~"
mkdir -p $backup
echo "...done"

echo "Backing up existing files and creating symlinks:"
for file in $files; do
	echo "Moving ~/.$file to $backup"
	mv ~/.$file $backup
	echo "Creating symlink to new $file in ~."
	ln -s $dir/$file ~/.$file
done
echo "...done"

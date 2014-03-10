#!/bin/bash
###
# .make.sh
# Creates symlinks in home directory for dotfiles
###

### Variables

dir=~/dotfiles
backup=~/dotfiles-backup
files="vimrc gitconfig bashrc bash_profile tmux.conf"

### Actions

# create dotfiles_old in ~
echo "Creating $backup for backup of any existing dotfiles in ~"
mkdir -p $backup
echo "...done"

# move any existing dotfiles in ~ to ~/dotfiles_old, and create symlinks
echo "Backing up existing files and creating symlinks:"
for file in $files; do
	echo "Moving $file from ~ to $backup"
	mv ~/.$file $backup
	echo "Creating symlink to new $file in ~."
	ln -s $dir/$file ~/.$file
done
echo "...done"

#!/bin/bash
###
# .make.sh
# Creates symlinks in home directory for dotfiles
###

### Variables

dir=~/dotfiles
olddir=~/dotfiles_old
files="vimrc gitconfig"

### Actions

# create dotfiles_old in ~
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in ~ to ~/dotfiles_old, and create symlinks
for file in $files; do
	echo "Moving any existing dotfiles from ~ to $olddir."
	mv ~/.$file ~/dotfiles_old/.
	echo "Creating symlink to $file in ~."
	ln -s $dir/$file ~/.$file
done

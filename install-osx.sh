#!/usr/bin/env bash

STOW_FOLDERS="ag bash bin bundler git javascript kitty neovim ruby timetrap todo vim zsh"

for dir in $STOW_FOLDERS; do
	echo "Stowing $dir"
	stow -D "$dir"
	stow "$dir"
done

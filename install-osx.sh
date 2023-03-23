#!/usr/bin/env bash

stow -R ag bash bin bundler git javascript kitty neovim ruby skhd timetrap todo yabai zsh 2> >(grep -v 'BUG in find_stowed_path? Absolute/relative mismatch' 1>&2)

#!/usr/bin/env bash

# need to make sure we have our brew binaries on the PATH; new installs may not have this set up yet!

PATH=$PATH:/opt/homebrew/bin

stow -R ag bash bin bundler git javascript kitty neovim ruby skhd timetrap todo yabai zsh 2> >(grep -v 'BUG in find_stowed_path? Absolute/relative mismatch' 1>&2)

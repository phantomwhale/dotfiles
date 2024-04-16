#!/usr/bin/env bash

# need to make sure we have our brew binaries on the PATH; new installs may not have this set up yet!

PATH=$PATH:/opt/homebrew/bin

stow --restow ag bash bin git javascript kitty neovim ruby skhd timetrap todo yabai zsh 2> >(grep -v 'BUG in find_stowed_path? Absolute/relative mismatch' 1>&2)

# don't stow the bundle folder, otherwise the bundler cache ends up in the dotfiles repo
stow --restow --no-folding bundler 2> >(grep -v 'BUG in find_stowed_path? Absolute/relative mismatch' 1>&2)

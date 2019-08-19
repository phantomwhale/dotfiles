#!/bin/bash

set -euo pipefail

# Perl is the simplest portable way to get the full path of the script
# https://www.commandlinefu.com/commands/view/9798/get-full-directory-path-of-a-script-regardless-of-where-it-is-run-from
abs_path=$(perl -MCwd -e "print Cwd::abs_path('$0')")
DOTFILES_DIR=$(cd $(dirname "$abs_path") && pwd)

exec "$DOTFILES_DIR/install/install-brew.sh"
exec "$DOTFILES_DIR/install/install-ssh.sh"
exec "$DOTFILES_DIR/install/install-symlinks.sh"
exec "$DOTFILES_DIR/install/install-ruby.sh"
exec "$DOTFILES_DIR/install/install-base16.sh"
exec "$DOTFILES_DIR/install/install-zsh.sh"
exec "$DOTFILES_DIR/install/install-nvim.sh"

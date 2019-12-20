#!/bin/bash

set -euo pipefail

if [ ! -x $(command -v brew) ]; then
  echo "Installing brew and all brewfile packages"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
echo "Update and cleanup brew"
brew update && brew cleanup

mkdir -p ~/.nvim  # Neovim needs this to be created

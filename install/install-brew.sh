#!/bin/bash

set -euo pipefail

echo "Installing brew and all brewfile packages"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew cleanup
#brew tap Homebrew/bundle
#brew bundle
mkdir -p ~/.nvim  # Neovim needs this to be created


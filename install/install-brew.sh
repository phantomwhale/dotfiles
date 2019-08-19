#!/bin/bash

set -euo pipefail

echo "Installing brew and all brewfile packages"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup
brew tap Homebrew/bundle
brew bundle
mkdir ~/.nvim  # Neovim needs this to be created


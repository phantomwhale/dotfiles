#!/bin/bash

set -euo pipefail

if ! [ -x "$(command -v brew)" ]; then
  echo "Installing brew and all brewfile packages"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Update and cleanup brew"
brew update && brew cleanup

echo "Installing from Brewfile"
brew bundle 

mkdir -p ~/.nvim  # Neovim needs this to be created

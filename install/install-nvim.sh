#!/bin/bash

set -eo pipefail

# Add neovim language support
npm install -g neovim
source /usr/local/share/chruby/chruby.sh
chruby ruby
gem install neovim
pip3 install --user --upgrade pynvim

# Used by coc-solargraph for ruby language server
gem install solargraph

echo "Installing nvim plugins"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c "PlugInstall 4" -c "qall"

echo "Install COC plugins"
cd ~/.config/coc/extensions
npm install

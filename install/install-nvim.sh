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

# TODO change this to use Packer
#echo "Installing nvim plugins"
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#nvim -c "PlugInstall 4" -c "qall"

# TODO check this works (is nvm installed at this point?)
# Required for TS development in vim (https://jose-elias-alvarez.medium.com/configuring-neovims-lsp-client-for-typescript-development-5789d58ea9c)
npm install -g typescript typescript-language-server diagnostic-languageserver eslint prettier

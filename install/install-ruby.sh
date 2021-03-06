#!/bin/bash

set -eo pipefail


function install_ruby {
  local version=$1
  echo "Installing ruby $version"
  ruby-install --no-reinstall ruby "$version"


  echo "Changing to ruby version $version"
  chruby ruby $version

  echo "Installing common tools"
  gem install --no-document timetrap neovim solargraph rufo
}

source /usr/local/share/chruby/chruby.sh

export CFLAGS="-Wno-error=implicit-function-declaration" # https://github.com/rbenv/ruby-build/issues/1747
install_ruby 2.6
install_ruby 2.7
install_ruby 3.0

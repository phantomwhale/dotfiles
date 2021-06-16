#!/bin/bash

set -eo pipefail

echo "Installing ruby 2.6"
export CFLAGS="-Wno-error=implicit-function-declaration" # https://github.com/rbenv/ruby-build/issues/1747
ruby-install --no-reinstall ruby 2.6
echo "Installing ruby 2.7"
ruby-install --no-reinstall ruby 2.7
echo "Installing latest ruby version"
ruby-install --no-reinstall ruby
echo "Changing to latest version"
source /usr/local/share/chruby/chruby.sh
chruby ruby
echo "Installing common tools - timetrap"
gem install --no-document  timetrap  # https://github.com/samg/timetrap/issues/176
echo "Installing neovim support gem"
gem install neovim
echo "Installing rufo for ruby formatting"
gem install rufo

#!/bin/bash

set -eo pipefail

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

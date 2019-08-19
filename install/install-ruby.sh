#!/bin/bash

set -euo pipefail

echo "Installing latest ruby version"
ruby-install ruby
echo "Changing to latest version"
source /usr/local/share/chruby/chruby.sh
chruby ruby
echo "Installing common tools - tmuxinator and timetrap"
gem install tmuxinator
gem install timetrap

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Set 256 color terminal
[ -z "$TMUX" ] && export TERM=xterm-256color

# TODO - get rid of all of this - use synlinks to /usr/local/bin on actual machine
# Customize to your needs...
export PATH=~/bin:~/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export JAVA_HOME="/usr/local/java/jdk1.7.0_45"
export PATH="$PATH:$JAVA_HOME/bin"

if [[ -s "${ZDOTDIR:-$HOME}/.bash/aliases" ]]; then
  source ~/.bash/aliases
fi

eval "$(rbenv init -)"

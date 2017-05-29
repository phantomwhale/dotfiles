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

# Customize to your needs...

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$PATH"

# bindkey for word boundries movement

bindkey -e;
bindkey '^[[1;9C' forward-word;
bindkey '^[[1;9D' backward-word;

# Set up my bash aliases
source ~/.bash/aliases

# Set up chruby
source /usr/local/share/chruby/chruby.sh
chruby 2.4.1

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-monokai.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

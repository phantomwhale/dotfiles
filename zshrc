# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:$PATH"

# bindkey for word boundries movement

bindkey -e;
bindkey '^[[1;9C' forward-word;
bindkey '^[[1;9D' backward-word;

# Set up bash aliases
source ~/.bash/aliases

# Set up chruby
source /usr/local/share/chruby/chruby.sh
chruby 2.4.1

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-monokai.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Setup antibody shell plugin manager
source <(antibody init)
antibody bundle < ~/.antibody.txt

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
chruby 2.4.2

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-monokai.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# key binding setup
source ~/.zsh/lib/keybinds.zsh

# history setup
source ~/.zsh/lib/history.zsh

# NVM setup
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# Setup antibody shell plugin manager
source <(antibody init)
antibody bundle < ~/.antibody.txt

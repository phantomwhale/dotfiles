# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:$PATH"

# set a GOPATH
export GOPATH="$HOME/go"

# Add go bin folder to path
export PATH="$PATH:$GOPATH/bin"

# Ensure we have enough space (100GB) for all the dockers
export VIRTUALBOX_DISK_SIZE=100000

# Give myself an hour when assuming AWS roles, rather than 15 minutes, preventing AWS console timeout hell
export AWS_ASSUME_ROLE_TTL=1h

# Lets edit with vim, because emacs is gross
# bindkey -e;
bindkey -v;

# bindkey for word boundries movement
# bindkey '^[[1;9C' forward-word;
# bindkey '^[[1;9D' backward-word;

# Establish neovim as default editor
export VISUAL=nvim
export EDITOR="$VISUAL"

# Set up bash aliases
source ~/.bash/aliases

# Set up chruby
source /usr/local/share/chruby/chruby.sh
chruby 2.6

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-monokai.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# key binding setup
source ~/.zsh/lib/keybinds.zsh

# history setup
source ~/.zsh/lib/history.zsh

# Ensure NVM is lazily loaded; this also avoids the tmux path_helper issues https://github.com/creationix/nvm/issues/1652
export NVM_LAZY_LOAD=true

# Setup antibody shell plugin manager
source <(antibody init)
antibody bundle < ~/.antibody.txt

# This seems to make my git completion work (https://stackoverflow.com/questions/26462667/git-completion-not-working-in-zsh-on-os-x-yosemite-with-homebrew)
autoload -U compinit && compinit

# kitty auto-completion
kitty + complete setup zsh | source /dev/stdin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

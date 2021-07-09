# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:$PATH"

# set a GOPATH
export GOPATH="$HOME/go"

# Required by go 1.13
export GOPRIVATE=github.com/99designs

# Add go bin folder to path
export PATH="$PATH:$GOPATH/bin"

# Add fastlane to path
export PATH="$HOME/.fastlane/bin:$PATH"

# Ensure we have enough space (100GB) for all the dockers
export HYPERKIT_DISK_SIZE=100000
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

# Set up chruby and change to latest ruby version
source /usr/local/share/chruby/chruby.sh
chruby ruby

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

# Make FZF use Ag (rather than default find) to lookup files names; this means .gitignore and .agignore exclusions are applied
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# kitty auto-completion
autoload -Uz compinit && compinit
kitty + complete setup zsh | source /dev/stdin

# add general zsh completions
fpath=(~/.zsh/completions $fpath)

# initialise Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# initialise fnm
eval "$(fnm env)"

if [ -x "$(command -v 99dev)" ] && [ -x "$(command -v docker-machine)" ]; then
  # autoload docker-machine env, if currently running
  if [ "$(docker-machine status $(99dev machine-name))" = "Running" ]; then
    eval $(docker-machine env $(99dev machine-name) 2> /dev/null)
  fi
fi

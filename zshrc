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
# source <(antibody init)
# antibody bundle < ~/.antibody.txt

# Make FZF use Ag (rather than default find) to lookup files names; this means .gitignore and .agignore exclusions are applied
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# This seems to make my git completion work (https://stackoverflow.com/questions/26462667/git-completion-not-working-in-zsh-on-os-x-yosemite-with-homebrew)
autoload -U compinit && compinit

# kitty auto-completion
kitty + complete setup zsh | source /dev/stdin

# add general zsh completions
fpath=(~/.zsh/completions $fpath)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# autoload docker-machine environment
if [ -x "$(command -v 99dev)" ]; then
  # Use the new hyperkit implementation
  export MACHINE_DRIVER=hyperkit

  # autoload docker-machine env, if running
  if [ "$(docker-machine status $(99dev machine-name))" = "Running" ]; then
    eval $(docker-machine env $(99dev machine-name) 2> /dev/null)
  fi
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zinit light zsh-users/zsh-autosuggestions
zinit light lukechilds/zsh-nvm           # NVM initialisation - also supports lazy loading, to stop NVM slowing down terminal loading
zinit light agkozak/zsh-z                # Z function for moving around
zinit light djui/alias-tips              # Remind me when I'm not using my aliases
zinit light zdharma/fast-syntax-highlighting         # hopefully this gives us syntax highlighting without breaking pure

# Completions
zinit ice blockf; zinit light zsh-users/zsh-completions

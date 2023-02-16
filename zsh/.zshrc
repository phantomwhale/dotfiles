# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:$PATH"

# Add homebrew into PATH
export PATH="$PATH:/opt/homebrew/bin"

# set a GOPATH
export GOPATH="$HOME/go"

# Required by go 1.13
export GOPRIVATE=github.com/99designs

# Add go bin folder to path
export PATH="$PATH:$GOPATH/bin"

# Add python bin dir to path (for ansible)
export PATH="$PATH:$HOME/Library/Python/3.9/bin/"

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

# Allow [ or ] in commands without erroring out
unsetopt nomatch

# Set up bash aliases
source ~/.bash/functions
source ~/.bash/aliases

# Set up chruby and change to latest ruby version
source $(brew --prefix)/share/chruby/chruby.sh
source $(brew --prefix)/share/chruby/auto.sh
chruby ruby

# enable frum
eval "$(frum init)"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/scripts/base16-monokai.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# key binding setup
source ~/.zsh/lib/keybinds.zsh

# history setup
source ~/.zsh/lib/history.zsh

# zsh functions
source ~/.zsh/lib/functions.zsh

# source antidote
source $(brew --prefix)/share/antidote/antidote.zsh

# initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# Make FZF use Ag (rather than default find) to lookup files names; this means .gitignore and .agignore exclusions are applied
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# kitty auto-completion
kitty + complete setup zsh | source /dev/stdin

# add general zsh completions
fpath=(~/.zsh/completions $(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

# initialise Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# initialise fnm
eval "$(fnm env --use-on-cd --version-file-strategy recursive)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

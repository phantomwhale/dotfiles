# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add homebrew to the start of PATH, to override `/usr/bin` and `/usr/sbin`
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:$PATH"

# Required by go 1.13
export GOPRIVATE=github.com/99designs,gitlab.com/vistaprint-org,go.99designs.dev

# Add go bin folder to path
export PATH="$PATH:$GOPATH/bin"

# Add python bin dir to path (for ansible)
export PATH="$PATH:$HOME/Library/Python/3.9/bin/"

# Add fastlane to path
export PATH="$HOME/.fastlane/bin:$PATH"

# Add postgres tools to path
export PATH="$(brew --prefix)/opt/libpq/bin:$PATH"

# Ensure we have enough space (100GB) for all the dockers
export HYPERKIT_DISK_SIZE=100000
export VIRTUALBOX_DISK_SIZE=100000

# Lets use OrbStack over Docker Desktop
export NNDEV_ORBSTACK=true

# Give myself an hour when assuming AWS roles, rather than 15 minutes, preventing AWS console timeout hell
export AWS_ASSUME_ROLE_TTL=1h

# No more guessing git; narrows down options for tab complete on git switch to a sane number
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

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

# Base16 Shell (don't run inside neovim terminal, as this causes an long wait and then IO error
if [[ -z "${NVIM}" ]]; then
  BASE16_SCHEME=$(cat $HOME/.base16_theme) 2> /dev/null
  kitty @ set-colors -c $HOME/.config/base16-kitty/colors/$BASE16_SCHEME.conf
fi

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

# add terraform zsh completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C $(brew --prefix)/bin/terraform terraform

# initialise Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# initialise fnm
eval "$(fnm env --use-on-cd --version-file-strategy recursive)"

# initialise zoxide
eval "$(zoxide init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

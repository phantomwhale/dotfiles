#
# Executes commands at login pre-zshrc.
#

#
# Tinty configuration directory
#
# Workaround for https://github.com/tinted-theming/tinty/issues/62
#
config_path="$XDG_CONFIG_HOME/tinted-theming/tinty/config.toml"
data_path="$XDG_DATA_HOME/tinted-theming/tinty"
alias tinty="tinty --config=\"$config_path\" --data-dir=\"$data_path\""
unset config_path data_path

#
# Browser
#
if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#
# Language
#
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Add homebrew to the start of PATH, to override `/usr/bin` and `/usr/sbin`
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:$PATH"

# Add go bin folder to path
export PATH="$PATH:$GOPATH/bin"

# Add python bin dir to path (for ansible)
export PATH="$PATH:$HOME/Library/Python/3.9/bin/"

# Add postgres tools to path
export PATH="$PATH:$(brew --prefix)/opt/libpq/bin"

# Add imagemagick scripts to bin
export PATH="$PATH:$HOME/.bin/imagemagick"

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

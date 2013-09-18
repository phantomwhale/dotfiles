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

# TODO - get rid of all of this - use synlinks to /usr/local/bin on actual machine
# Customize to your needs...
export PATH=~/bin:~/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/home/bturner/software/CloudWatch0.0.12.1/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:~/software/todo.txt_cli-2.8:/home/bturner/software/phantomjs-1.7.0-linux-x86_64/bin
export PATH="$PATH:~/software/apache-jmeter-2.8/bin"
export PATH="$PATH:~/software/ec2-api-tools-1.6.6.4/bin"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

if [[ -s "${ZDOTDIR:-$HOME}/.bash_aliases" ]]; then
  source ~/.bash_aliases
fi

eval "$(rbenv init - zsh)"

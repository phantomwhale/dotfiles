# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

DISABLE_LS_COLORS="false"

plugins=(git bundler gem rbates)

# Customize to your needs...
export PATH=~/bin:~/.bin:/usr/local/homebrew/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/home/bturner/software/CloudWatch0.0.12.1/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:~/software/todo.txt_cli-2.8:/home/bturner/software/phantomjs-1.7.0-linux-x86_64/bin
export PATH="$PATH:~/software/apache-jmeter-2.8/bin"
export PATH="$PATH:~/software/ec2-api-tools-1.6.6.4/bin"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

source ~/.bash_aliases
source $ZSH/oh-my-zsh.sh
eval "$(rbenv init -)"

#!/bin/bash

set -euo pipefail

if [[ $SHELL =~ "zsh" ]]; then
	echo "already using zsh"
else
	echo "switch to zsh? (recommended) [ynq] "
	read -r answer
	case $answer in
	y)
		echo "switching to zsh"
		sudo dscl . -create "/Users/$USER" UserShell "$(which zsh)"
		exec zsh
		;;
	q)
		exit
		;;
	*)
		echo "skipping zsh"
		;;
	esac
fi

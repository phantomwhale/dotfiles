#!/bin/bash

set -euo pipefail

echo "Setting up SSH keys"
echo "Ensure ~/.ssh exists"
mkdir -p ~/.ssh

if [ -f ~/.ssh/id_rsa ]; then
	echo "SSH key already exists, skipping..."
	exit 0
fi

echo "Input 1password vault:"
read -r vault
echo "Input secret key for 1password vault:"
read -r secret

# TODO: don't override file if it already exists
eval "$(op signin "$vault" ben.turner@pobox.com "$secret")" && op get document id_rsa >~/.ssh/id_rsa
# TODO: retry if file doesn't now exist

chmod 600 ~/.ssh/id_rsa
ssh-add ~/.ssh/id_rsa
ssh-keygen -y -f ~/.ssh/id_rsa >~/.ssh/id_rsa.pub

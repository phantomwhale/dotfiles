#!/bin/bash

set -euo pipefail

INSTALL_DIR="$HOME/config/base16-shell"
echo "Installing base16 shell options"
if [ ! -e "$INSTALL_DIR" ]; then
	git clone git@github.com:chriskempson/base16-shell.git "$INSTALL_DIR"
else
	echo "Directory $INSTALL_DIR already exists; skipping"
fi

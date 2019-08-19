#!/bin/bash

set -euo pipefail

DOTFILES_DIR=$(cd $(dirname "$0")/.. && pwd)

link_file() {
  local infile=$1
  local outfile=$2
  echo "linking $1"
  ln -s "$1" "$2"
}

replace_file() {
  local infile=$1
  local outfile=$2
  rm "$2"
  link_file "$@"
}

replace_files() {
  local dir="$1"
  echo "Parsing files in $dir"
  local replace_all=false
  for infile in "$dir"/*; do
    local filename=$(basename $infile)
    if ! $(grep -Fxq "$filename" "$dir/.symignore") && [ -f "$infile" ]; then
      local outfile="$HOME/.$filename"
      if [ -L "$outfile" ]; then
        if [ "$replace_all" = true ]; then
          replace_file "$infile" "$outfile"
        else
          echo "overwrite $outfile? [ynaq] "
          read reply
          case $reply in
            y)
              replace_file "$infile" "$outfile"
              ;;
            n)
              echo "skipping $outfile"
              ;;
            a)
              replace_all=true
              replace_file "$infile" "$outfile"
              ;;
            q)
              echo "quitting"
              return
              ;;
          esac
        fi
      else
        link_file "$infile" "$outfile"
      fi
    fi
  done
}

replace_files "$DOTFILES_DIR"

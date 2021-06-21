#!/bin/bash

set -euo pipefail

DOTFILES_DIR=$(cd $(dirname "$0")/.. && pwd)

link() {
  local in=$1
  local out=$2
  echo "linking $1"
  ln -s "$1" "$2"
}

replace() {
  local in=$1
  local out=$2
  rm "$out"
  link "$@"
}

replaces() {
  local dir="$1"
  echo "Parsing files in $dir"
  local replace_all=false
  for infile in "$dir"/*; do
    local filename=$(basename $infile)
    if ! $(grep -Fxq "$filename" "$dir/.symignore"); then
      local outfile="$HOME/.$filename"
      if [ -L "$outfile" ]; then
        if [ "$replace_all" = true ]; then
          replace "$infile" "$outfile"
        else
          echo "overwrite $outfile? [ynaq] "
          read reply
          case $reply in
            y)
              replace "$infile" "$outfile"
              ;;
            n)
              echo "skipping $outfile"
              ;;
            a)
              replace_all=true
              replace "$infile" "$outfile"
              ;;
            q)
              echo "quitting"
              return
              ;;
          esac
        fi
      else
        link "$infile" "$outfile"
      fi
    fi
  done
}

replace_config_dirs() {
  local dir="$1"
  echo "Parsing directories in $dir"
  local replace_all=false
  mkdir -p ~/.config
  for indir in "$dir"/*; do
    local dirname=$(basename $indir)
    if [ -d "$indir" ]; then
      local outdir="$HOME/.config/$dirname"
      if [ -L "$outdir" ]; then
        if [ "$replace_all" = true ]; then
          replace "$indir" "$outdir"
        else
          echo "overwrite $outdir? [ynaq] "
          read reply
          case $reply in
            y)
              replace "$indir" "$outdir"
              ;;
            n)
              echo "skipping $outdir"
              ;;
            a)
              replace_all=true
              replace "$indir" "$outdir"
              ;;
            q)
              echo "quitting"
              return
              ;;
          esac
        fi
      else
        link "$indir" "$outdir"
      fi
    fi
  done

}

replaces "$DOTFILES_DIR"
replace_config_dirs "$DOTFILES_DIR/config"

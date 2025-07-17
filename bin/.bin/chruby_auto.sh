unset RUBY_AUTO_VERSION

function chruby_auto() {
  local dir="$PWD/" version

  until [[ -z "$dir" ]]; do
    dir="${dir%/*}"

    # First check for .ruby-version
    if { read -r version <"$dir/.ruby-version"; } 2>/dev/null || [[ -n "$version" ]]; then
      version="${version%%[[:space:]]}"
    # If no .ruby-version, check for .tool-versions
    elif [[ -f "$dir/.tool-versions" ]]; then
      version=$(grep '^ruby ' "$dir/.tool-versions" 2>/dev/null | awk '{print $2}')
      version="${version%%[[:space:]]}"
    else
      continue
    fi

    if [[ -n "$version" ]]; then
      if [[ "$version" == "$RUBY_AUTO_VERSION" ]]; then
        return
      else
        RUBY_AUTO_VERSION="$version"
        chruby "$version"
        return $?
      fi
    fi
  done

  if [[ -n "$RUBY_AUTO_VERSION" ]]; then
    chruby_reset
    unset RUBY_AUTO_VERSION
  fi
}

if [[ -n "$ZSH_VERSION" ]]; then
  if [[ ! "$preexec_functions" == *chruby_auto* ]]; then
    preexec_functions+=("chruby_auto")
  fi
elif [[ -n "$BASH_VERSION" ]]; then
  trap '[[ "$BASH_COMMAND" != "$PROMPT_COMMAND" ]] && chruby_auto' DEBUG
fi

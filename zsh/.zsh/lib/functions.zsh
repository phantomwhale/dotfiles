# Git checkout branches with fuzzy finder
#
# Lovingly stolen from https://gist.github.com/plasticine/0953b7114060c34b5d122cdb48a151dd
#
function gcob() {
  local format branch branches
  format="%(committerdate:relative)\\%(color:green)%(refname:short)%(color:reset)\\%(HEAD)\\%(color:yellow)%(objectname:short)%(color:reset) %(upstream:trackshort)\\%(contents:subject)"
  branches=$(git for-each-ref --format="$format" --sort=-committerdate refs/heads/ | column -t -s "\\") &&
  branch=$(echo "$branches" | fzf --ansi --height=15 --border) &&
  git checkout $(echo "$branch" | awk '{print $4}')
}

#
# Grep all bundled gems - thanks to @sj26 for this one
#
brg() {
  rg "$@" "${(@f)$(bundle list --paths)}"
}

# Load 1pass credentials into envrionment
#
# Ref: https://www.gruntwork.io/blog/how-to-securely-store-secrets-in-1password-cli-and-load-them-into-your-zsh-shell-when-needed
env-op() {
  # Allow multiple search strings to be passed in
  local search_string="$@"
  read -A search_values <<< "$search_string"
  for ((i = 1 ; i <= $#search_values ; i++)) ; do
    if [[ "$search_values[$i]" != "" ]] ; then
      search=$search_values[$i]
    fi
    keys_string=$(op item get --fields label=username "$search")
    if [[ $? != 0 ]] ; then
      return
    fi
    values_string=$(op item get --fields label=credential --reveal "$search")
    read -A keys <<< "$keys_string"
    read -A values <<< "$values_string"
    # If we store "AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY" in the username field
    # and "secret1 secret2" in the password field, we'll map them accordingly.
    # If there are fewer secrets than usernames (space separated), then we'll
    # use the last value for the rest of the secrets mapped to usernames.
    # For example: "GITHUB_TOKEN GITHUB_AUTH_TOKEN" with a password of "foo" will
    # set both environment variables to "foo".
    # echo $keys
    for ((j = 1 ; j <= $#keys ; j++)) ; do
      if [[ "$values[$j]" != "" ]] ; then
        last_value=$values[$j]
      fi
      export $keys[$j]=$last_value
      >&2 echo "Loaded $keys[$j]"
    done
  done
}

# Used by ai functions below
_has() {
  return $( whence $1 &>/dev/null )
}

source ~/.zsh/lib/ai_functions.zsh

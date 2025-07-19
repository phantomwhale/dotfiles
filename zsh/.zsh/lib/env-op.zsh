env-op() {
  local search="$@"
  keys_string=$(op item get --fields label=username  "$search")
  if [[ $? != 0 ]] ; then
    return
  fi
  values_string=$(op item get --fields label=credential "$search")
  read -A keys <<< "$keys_string"
  read -A values <<< "$values_string"
  # If we store "AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY" in the username field
  # and "secret1 secret2" in the password field, we'll map them accordingly.
  # If there are fewer secrets than usernames (space separated), then we'll
  # use the last value for the rest of the secrets mapped to usernames.
  # For example: "GITHUB_TOKEN GITHUB_AUTH_TOKEN" with a password of "foo" will
  # set both environment variables to "foo".
  for ((i = 1 ; i <= $#keys ; i++)) ; do
    if [[ "$values[$i]" != "" ]] ; then
      last_value=$values[$i]
    fi
    export $keys[$i]=$last_value
    >&2 echo "Loaded $keys[$i]"
  done
}

env-op "$@"

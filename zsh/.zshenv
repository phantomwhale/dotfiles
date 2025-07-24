#
# Defines environment variables.
#

# Load private API keys, if defined
if [[ -s "${ZDOTDIR:-$HOME}/.private_env" ]]; then
  source "${ZDOTDIR:-$HOME}/.private_env"
fi

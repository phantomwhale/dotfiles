#
# Defines environment variables.
#

# Load private API keys, if defined
if [[ -s "${ZDOTDIR:-$HOME}/.zshenv.local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshenv.local"
fi

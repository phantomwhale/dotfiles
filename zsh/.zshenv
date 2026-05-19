#
# Defines environment variables.
#
export OMO_SEND_ANONYMOUS_TELEMETRY=0

# Load private API keys, if defined
if [[ -s "${ZDOTDIR:-$HOME}/.zshenv.local" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshenv.local"
fi

# Generic helper to ask an LLM about anything - install glow for best results
# Requires `llm`: https://llm.datasette.io/en/stable/
ask() {
  if [ $# = 0 ]; then
    echo "usage: ask <some question>"
    return 1
  fi
  if ! _has llm; then
    echo "llm tool not installed, run 'uv tool install llm'"
    return
  fi
  local formatter=cat
  if _has glow; then
    formatter=glow
  elif _has md2term; then
    formatter=md2term
  fi
  local system_prompt="We are on the command line for a system identified as \`$(uname -a)\` with locale \`$LANG\`. Answer the following question. Be brief and concise."
  llm prompt -s "$system_prompt" "$*" | eval $formatter
}

# Ask an LLM with WebSearch tool enabled
# Requires `llm`: https://llm.datasette.io/en/stable/
# (I suggest `llm install llm-tools-exa` and getting a key from exa.ai)
askw() {
  if [ $# = 0 ]; then
    echo "usage: ask-web <some question>"
    return 1
  fi
  if ! _has llm; then
    echo "llm tool not installed, run 'uv tool install llm'"
    return
  fi
  if ! llm tools list | grep -q web_search; then
    echo "web_search tool not available in llm"
    return 1
  fi
  local formatter=cat
  if _has glow; then
    formatter=glow
  elif _has md2term; then
    formatter=md2term
  fi
  local system_prompt="We are on the command line for a system identified as \`$(uname -a)\` with locale \`$LANG\`. Search the web and answer the following question. Be brief and concise."
  llm prompt -T web_search -s "$system_prompt" "$*" | eval $formatter
}

# AI helper for command line syntax, like "list subprocesses of pid 1234"
# Requires `llm`: https://llm.datasette.io/en/stable/
cmd() {
  if [ $# = 0 ]; then
    echo "usage: cmd <some command description>"
    return 1
  fi
  if ! _has llm; then
    echo "llm tool not installed, run 'uv tool install llm'"
    return
  fi
  local system_prompt="We are on the command line for a system identified as \`$(uname -a)\` with locale \`$LANG\` using shell \`$SHELL\`. Show me a command line command for the following in a code block. Be brief and concise. No comments."
  local cmd
  cmd=$(llm prompt -x -s "$system_prompt" "$*")

  # Insert the command into the command line buffer
  print -z "$cmd"
}

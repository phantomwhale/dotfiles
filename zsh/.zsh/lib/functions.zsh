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

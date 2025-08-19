local lsp_utils = require("modules.lsp-utils")
local rubocop_exec = lsp_utils.check_executable({
  { cmd = { "bundle", "exec", "rubocop", "--lsp" },     check = "bundle exec rubocop --version" },
  { cmd = { "mise", "exec", "--", "rubocop", "--lsp" }, check = "mise exec -- rubocop --version" },
  { cmd = { "rubocop", "--lsp" },                       check = "rubocop --version" },
})

table.insert(rubocop_exec, "--ignore-unrecognized-cops")
table.insert(rubocop_exec, "--config")
table.insert(rubocop_exec, vim.fn.expand('$HOME/.rubocop.yml'))

return {
  cmd = rubocop_exec,
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" }
}

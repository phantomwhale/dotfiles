local lsp_utils = require("modules.lsp-utils")

return {
  cmd = lsp_utils.check_executable({
    { cmd = { "bundle", "exec", "ruby-lsp" },     check = "bundle exec ruby-lsp --version" },
    { cmd = { "mise", "exec", "--", "ruby-lsp" }, check = "mise exec -- ruby-lsp --version" },
    { cmd = { "ruby-lsp" },                       check = "ruby-lsp --version" },
  }),
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile', '.git' },
  init_options = {
    formatter = 'auto',
  },
}

local lsp_utils = require("modules.lsp-utils")

return {
  cmd = lsp_utils.check_executable({
    { cmd = { "mise", "x", "--", "ruby-lsp" } },
    { cmd = { "bundle", "exec", "ruby-lsp" } },
    { cmd = { "ruby-lsp" } },
  }),
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile', '.git' },
  init_options = {
    formatter = 'auto',
  },
}

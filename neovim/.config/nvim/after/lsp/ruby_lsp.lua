local lsp_utils = require("modules.lsp-utils")

return {
  -- Spawn from the resolved `root_dir` so `mise x` picks the project's
  -- mise.toml Ruby without depending on the cwd (e.g. vim-rooter).
  cmd = function(dispatchers, config)
    local cmd = lsp_utils.check_executable({
      { cmd = { "mise", "x", "--", "ruby-lsp" } },
      { cmd = { "bundle", "exec", "ruby-lsp" } },
      { cmd = { "ruby-lsp" } },
    })
    local root = config.root_dir or vim.fn.getcwd()
    return vim.lsp.rpc.start(cmd, dispatchers, { cwd = root })
  end,
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile', '.git' },
  init_options = {
    -- rubocop formatting and linting are owned by the dedicated `rubocop` LSP
    -- (see after/lsp/rubocop.lua). Disabling them here keeps a single rubocop in
    -- play: otherwise both servers format on save (double work) and publish the
    -- same offences (duplicate diagnostics). ruby_lsp still drives navigation,
    -- completion, hover, rename, etc. Empty `linters = {}` encodes to JSON `[]`,
    -- which ruby-lsp reads as "no linters" instead of auto-detecting rubocop.
    formatter = 'none',
    linters = {},
  },
}

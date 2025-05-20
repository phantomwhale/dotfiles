return {
  'Exafunction/windsurf.vim',
  event = 'BufEnter',
  config = function()
    vim.g.codeium_enabled = false
  end
}

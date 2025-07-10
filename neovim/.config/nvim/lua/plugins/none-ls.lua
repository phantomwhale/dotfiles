return {
  -- use neovim as a custom language server for diagnostics, code actions and more
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'lewis6991/gitsigns.nvim'
  }
}

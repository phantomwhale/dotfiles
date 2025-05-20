return {
  -- use neovim as a custom language server for diagnostics, code actions and more
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
    'lewis6991/gitsigns.nvim'
  }
}

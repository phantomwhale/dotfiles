return {
  -- Highlight, edit and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "ruby", "javascript", "typescript", "go", "hcl", "html", "vim", "vimdoc" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
        endwise = { enable = true },
      })
    end
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  { "RRethy/nvim-treesitter-endwise" },

  -- tree-sitter grammer for proto3
  { 'mitchellh/tree-sitter-proto' },
}

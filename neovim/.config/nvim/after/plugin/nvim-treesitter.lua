require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "ruby",
    "javascript",
    "typescript",
    "go",
    "hcl",
    "yaml",
  },
  highlight = {
    enable = true,
    -- doesn't seem to work?
    disable = function(lang, bufnr) -- Disable in large Json buffers
      return lang == "json" and vim.api.nvim_buf_line_count(bufnr) > 1000
    end,
  },
}

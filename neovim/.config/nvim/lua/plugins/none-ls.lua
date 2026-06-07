return {
  -- use neovim as a custom language server for diagnostics, code actions and more
  'nvimtools/none-ls.nvim',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'lewis6991/gitsigns.nvim',
    'mason-org/mason.nvim',
  },
  config = function()
    local none_ls = require("null-ls")
    local b = none_ls.builtins

    none_ls.setup({
      sources = {
        b.code_actions.gitsigns,
        b.diagnostics.write_good,
        b.diagnostics.markdownlint,
        -- b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
        b.formatting.prettier.with({
          prefer_local = 'node_modules/.bin',
          disabled_filetypes = { "yaml", "markdown" },
        }),

        -- b.formatting.trim_whitespace.with({ filetypes = { "tmux", "teal", "zsh" } }),
        b.formatting.shfmt.with({
          extra_args = { "-i", "2", "-ci" },
        }),
      },
      flags = {
        debounce_text_changes = 5000,
      }
    })
  end,
}

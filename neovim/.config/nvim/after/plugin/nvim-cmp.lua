local cmp = require "cmp"

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  window = {},

  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),

  sources = cmp.config.sources({
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" }, -- only enables itself inside of lua
    { name = "luasnip" },
    { name = "path" },
  }, {
    { name = "buffer", keyword_length = 5 } -- only suggest buffer when no matches in previous group
  }),

  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      },
    },
  },
}

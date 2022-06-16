local cmp = require "cmp"

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  window = {},

  mapping = cmp.mapping.preset.insert({
    --["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    --["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lua" }, -- only enables itself inside of lua
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" },
  }, {
    { name = "buffer", keyword_length = 5 }
  }),
}

local lsp_ok, lspconfig = pcall(require, 'lspconfig')
if (not lsp_ok) then return end

local cmp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if (not cmp_ok) then return end

local capabilities = cmp_nvim_lsp.default_capabilities()

vim.cmd("command! LspFormat lua vim.lsp.buf.format( { timeout_ms = 5000 } )")
vim.keymap.set('n', '<space>f', ':LspFormat<CR>', { noremap = true, silent = true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings
  local keymap = vim.keymap

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })

  -- set keybinds
  local opts = { noremap = true, silent = true }

  opts.desc = "Go to declaration"
  keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

  opts.desc = "Go to definition"
  keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

  -- opts.desc = "Show documentation for what is under cursor"
  -- keymap.set('n', 'K', vim.lsp.buf.hover, opts)

  opts.desc = "Show LSP implementation"
  keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

  opts.desc = "Show method signautre (?)"
  keymap.set('n', 'gh', vim.lsp.buf.signature_help, opts)

  opts.desc = "Show LSP type definitions"
  keymap.set('n', 'gp', vim.lsp.buf.type_definition, opts)

  opts.desc = "Smart rename"
  keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

  opts.desc = "Show LSP references"
  keymap.set('n', 'gr', vim.lsp.buf.references, opts)

  opts.desc = "Go to previous diagnostic"
  keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

  opts.desc = "Go to next diagnostic"
  keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

  opts.desc = "Show diagnostics in floating window"
  keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

  opts.desc = "Show documentation for what is under cursor"
  keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

  opts.desc = "Undocumented at this stage"
  keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  if client.server_capabilities.documentFormattingProvider then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ timeout_ms = 5000 })
      end,
    })
  end
end

lspconfig.ruby_lsp.setup({
  on_attach = on_attach,
  formatter = 'none'
})

lspconfig.rubocop.setup({
  cmd = { "rubocop", "--lsp", "--ignore-unrecognized-cops", "--config", vim.fn.expand('$HOME/.rubocop.yml') }
})

lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,

  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  }
})

lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach
})

-- ts_ls.setup(on_attach)

lspconfig.terraformls.setup({})
lspconfig.tflint.setup({})

-- luasnip setup
local luasnip = require 'luasnip'

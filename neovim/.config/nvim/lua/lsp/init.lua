local nvim_lsp = require('lspconfig')

local cmp_nvim_lsp = require('cmp_nvim_lsp')

local tsserver = require("lsp.tsserver")

vim.cmd("command! LspFormat lua vim.lsp.buf.format( { timeout_ms = 5000 } )")
vim.keymap.set('n', '<space>f', ':LspFormat<CR>', { noremap=true, silent=true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr or 0, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr or 0, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- commands
  vim.cmd("command! LspHover          lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename         lua vim.lsp.buf.rename()")
  vim.cmd("command! LspDiagPrev       lua vim.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext       lua vim.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine       lua vim.diagnostic.open_float()")
  vim.cmd("command! LspReferences     lua vim.lsp.buf.references()")
  vim.cmd("command! LspSignatureHelp  lua vim.lsp.buf.signature_help()")
  vim.cmd("command! LspDef            lua vim.lsp.buf.definition()")
  vim.cmd("command! LspTypeDef        lua vim.lsp.buf.type_definition()")

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd',        ':LspDef<CR>', opts)
  buf_set_keymap('n', 'K',         ':LspHover<CR>', opts)
  buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gh',        '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gt',        ':LspTypeDef<CR>', opts)
  buf_set_keymap('n', '<space>rn', ':LspRename<CR>', opts)
  buf_set_keymap('n', 'gr',        ':LspReferences<CR>', opts)
  buf_set_keymap('n', '<space>e',  ':LspDiagLine<CR>', opts)
  buf_set_keymap('n', '[d',        ':LspDiagPrev<CR>', opts)
  buf_set_keymap('n', ']d',        ':LspDiagNext<CR>', opts)

  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

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

local capabilities = cmp_nvim_lsp.default_capabilities()

nvim_lsp["ruby_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

nvim_lsp["lua_ls"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

nvim_lsp["gopls"].setup({
  capabilities = capabilities,
  on_attach = on_attach
})

tsserver.setup(on_attach)

-- luasnip setup
local luasnip = require 'luasnip'

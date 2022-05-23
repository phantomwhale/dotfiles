local nvim_lsp = require('lspconfig')

local null_ls = require("lsp.null-ls")
local tsserver = require("lsp.tsserver")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr or 0, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr or 0, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- commands
  vim.cmd("command! LspFormatting     lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspHover          lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename         lua vim.lsp.buf.rename()")
  vim.cmd("command! LspDiagPrev       lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext       lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine       lua vim.lsp.diagnostic.show_line_diagnostics()")
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
  -- buf_set_keymap('n', '<C-k>',  '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D',  ':LspTypeDef', opts)
  buf_set_keymap('n', '<space>rn', ':LspRename<CR>', opts)
  buf_set_keymap('n', 'gr',        ':LspReferences<CR>', opts)
  buf_set_keymap('n', '<space>e',  ':LspDiagLine<CR>', opts)
  buf_set_keymap('n', '[d',        ':LspDiagPrev<CR>', opts)
  buf_set_keymap('n', ']d',        ':LspDiagNext<CR>', opts)
  buf_set_keymap('n', '<space>f',  ':LspFormatting<CR>', opts)

  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>q',  '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup LspAutocommands
           autocmd! * <buffer>
           autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]], true)
  end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'solargraph', 'gopls', 'phpactor'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = function(client)
      client.resolved_capabilities.document_formatting = true
      on_attach(client)
    end,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
tsserver.setup(on_attach)
null_ls.setup(on_attach)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

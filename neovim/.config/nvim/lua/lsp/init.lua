vim.lsp.enable({
  'ruby_lsp',
  'rubocop',
  'gopls',
  'lua_ls',
  'herb_ls',
  'phpactor',
  'terraformls',
  'tflint',
  'vale_ls',
  'yamlls'
})

-- Ruby LSP returns empty definitions while it builds its initial index, which
-- renders as a misleading "no definition found". Track its indexing progress
-- (token "indexing-progress") so gd can report the real reason instead.
local indexing = {}

vim.api.nvim_create_autocmd('LspProgress', {
  group = vim.api.nvim_create_augroup('my.lsp.indexing', {}),
  callback = function(args)
    local value = args.data and args.data.params and args.data.params.value
    if not (value and args.data.params.token == 'indexing-progress') then
      return
    end
    indexing[args.data.client_id] = value.kind ~= 'end'
  end,
})

local function ruby_lsp_indexing(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr, name = 'ruby_lsp' })) do
    if indexing[client.id] then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
    local opts = { noremap = true, silent = true }

    if client:supports_method('textDocument/formatting') then
      vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts)
    end

    opts.desc = "Go to declaration"
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)

    opts.desc = "Go to definition"
    vim.keymap.set('n', 'gd', function()
      if ruby_lsp_indexing(0) then
        vim.notify('Ruby LSP is still indexing, definitions not ready yet', vim.log.levels.WARN)
        return
      end
      vim.lsp.buf.definition()
    end, opts)

    -- opts.desc = "Show documentation for what is under cursor"
    -- keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    opts.desc = "Show LSP type definitions"
    vim.keymap.set('n', 'gp', vim.lsp.buf.type_definition, opts)

    if client:supports_method('textDocument/rename') then
      opts.desc = "Smart rename"
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    end

    opts.desc = "Show LSP references"
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)

    opts.desc = "Show diagnostics in floating window"
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)

    opts.desc = "Show documentation for what is under cursor"
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    opts.desc = "Undocumented at this stage"
    vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    vim.keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    if client:supports_method('textDocument/documentHighlight') then
    end
    if client:supports_method('textDocument/inlayHint') then
    end
    if client:supports_method('textDocument/codeLens') then
    end
    if client:supports_method('textDocument/foldingRange') then
    end
    if client:supports_method('textDocument/implementation') then
      opts.desc = "Show LSP implementation"
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    end

    -- Auto-complete whilst typing
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

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
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)

    -- opts.desc = "Show documentation for what is under cursor"
    -- keymap.set('n', 'K', vim.lsp.buf.hover, opts)

    opts.desc = "Show LSP implementation"
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    opts.desc = "Show LSP type definitions"
    vim.keymap.set('n', 'gp', vim.lsp.buf.type_definition, opts)

    if client:supports_method('textDocument/rename') then
      opts.desc = "Smart rename"
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    end

    opts.desc = "Show LSP references"
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    opts.desc = "Go to previous diagnostic"
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

    opts.desc = "Go to next diagnostic"
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

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

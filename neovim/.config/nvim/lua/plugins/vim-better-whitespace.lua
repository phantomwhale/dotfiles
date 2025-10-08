-- show trailing whitespace
return {
  'ntpeters/vim-better-whitespace',
  config = function()
    -- https://github.com/ntpeters/vim-better-whitespace/issues/158
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = '*',
      command = 'DisableWhitespace',
    })
  end
}

return {
  -- Parser management only — highlighting/indent uses native vim.treesitter APIs
  -- The old nvim-treesitter.configs API was removed; 'main' branch is for Neovim 0.12+
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    init = function()
      -- Native tree-sitter highlighting and indentation (registered early so
      -- it fires for buffers opened from the command line during startup)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('treesitter-start', { clear = true }),
        callback = function(args)
          if pcall(vim.treesitter.start) then
            -- Treesitter indentation (disabled for Ruby where it's unreliable)
            if vim.bo[args.buf].filetype ~= 'ruby' then
              vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end
          end
        end,
      })
    end,
    config = function()
      local ensure_installed = { "ruby", "javascript", "typescript", "go", "hcl", "html", "vim", "vimdoc", "yaml" }
      local installed = require('nvim-treesitter.config').get_installed()
      local to_install = vim.iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(installed, parser)
        end)
        :totable()

      if #to_install > 0 then
        require('nvim-treesitter').install(to_install)
      end
    end,
  },

  -- NOTE: nvim-treesitter-endwise is incompatible with the main branch rewrite.
  -- Consider tpope/vim-endwise as a drop-in replacement when ready.

  -- tree-sitter grammar for proto3
  { 'mitchellh/tree-sitter-proto', ft = "proto" },
}

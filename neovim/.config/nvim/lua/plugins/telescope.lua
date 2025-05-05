return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local telescope = require("telescope")
    telescope.load_extension('fzf')
    telescope.load_extension("dir")
    telescope.load_extension('zoxide')

    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case". The default case_mode is "smart_case"
        }
      },
      pickers = {
        find_files = {
          find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
        },
        grep_string = {
          additional_args = { "--hidden" }
        },
        live_grep = {
          additional_args = { "--hidden" }
        },
        oldfiles = {
          cwd_only = true,
        }
      }
    })
  end
}

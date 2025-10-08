return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },

    opts = {
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
          additional_args = { '--hidden', '--iglob', '!.git' }
        },
        live_grep = {
          additional_args = { '--hidden' }
        },
        oldfiles = {
          cwd_only = true,
        }
      }
    },
    keys = {
      { '<leader>?',       "<cmd>Telescope oldfiles<cr>",     desc = '[?] Find recently opened files' },
      { '<leader><space>', "<cmd>Telescope buffers<cr>",      desc = '[ ] Find existing buffers' },
      { '<leader>sf',      "<cmd>Telescope find_files<cr>",   desc = '[S]earch [F]iles' },
      { '<leader>sh',      "<cmd>Telescope help_tags<cr>",    desc = '[S]earch [H]elp' },
      { '<leader>sw',      "<cmd>Telescope grep_string<cr>",  desc = '[S]earch current [W]ord' },
      { '<leader>sd',      "<cmd>Telescope diagnostics<cr>",  desc = '[S]earch [D]iagnostics' },
      { '<leader>sr',      "<cmd>Telescope git_branches<cr>", desc = '[S]earch git b[R]anches' },
    }
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  {
    'princejoogie/dir-telescope.nvim',
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  {
    'jvgrootveld/telescope-zoxide',
    keys = {
      { "<leader>sz", desc = "Search Zoxide" },
    }
  }
}

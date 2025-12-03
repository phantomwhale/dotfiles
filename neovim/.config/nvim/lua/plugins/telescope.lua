-- Custom finder to grep open buffers only
local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

-- Custom finder for base16 colours
local function telescope_pick_base16_color()
  local colors = vim.fn.getcompletion('base16', 'color')
  local theme = require('telescope.themes').get_dropdown()
  local telescope_action_set = require('telescope.actions.set')
  local telescope_action_state = require('telescope.actions.state')
  require('telescope.pickers').new(theme, {
    prompt_title = 'Base16 Colorschemes',
    finder = require('telescope.finders').new_table({ results = colors }),
    sorter = require('telescope.config').values.generic_sorter(theme),
    attach_mappings = function(bufnr)
      telescope_actions.select_default:replace(function()
        local name = telescope_action_state.get_selected_entry().value
        os.execute('tinty apply ' .. name)
        vim.cmd('colorscheme ' ..
          vim.fn.readfile(vim.fn.expand(vim.env.HOME .. '.local/share/tinted-theming/tinty/current_scheme'))
          [1])
        telescope_actions.close(bufnr)
      end)
      telescope_action_set.shift_selection:enhance({
        post = function()
          local name = telescope_action_state.get_selected_entry().value
          vim.cmd('colorscheme ' .. name)
        end
      })
      return true
    end
  }):find()
end

local function current_buffer_fuzzy_find()
  -- can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end

return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = "Telescope",
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      },
      {
        'jvgrootveld/telescope-zoxide',
        dependencies = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' }
      },
      {
        'princejoogie/dir-telescope.nvim',
        dependencies = { "nvim-telescope/telescope.nvim" }
      },
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case". The default case_mode is "smart_case"
        },
        zoxide = {},
        dir = {}
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
      { '<leader>fr',      "<cmd>Telescope oldfiles<cr>",          desc = '[F]ind [R]ecent files' },
      { '<leader><space>', "<cmd>Telescope buffers<cr>",           desc = '[ ] Find existing buffers' },
      { '<leader>/',       current_buffer_fuzzy_find,              desc = '[/] Fuzzily search in current buffer' },
      { '<leader>sb',      telescope_live_grep_open_files,         desc = '[S]earch open [B]uffers' },
      { '<leader>sc',      telescope_pick_base16_color,            desc = '[S]earch [C]olour themes' },
      { '<leader>sd',      "<cmd>Telescope diagnostics<cr>",       desc = '[S]earch [D]iagnostics' },
      { '<leader>sf',      "<cmd>Telescope find_files<cr>",        desc = '[S]earch [F]iles' },
      { '<leader>sF',      "<cmd>Telescope dir find_files<cr>",    desc = '[S]earch [F]iles in directory' },
      { '<leader>sg',      "<cmd>Telescope live_grep<cr>",         desc = '[S]earch by [G]rep' },
      { '<leader>sG',      "<cmd>Telescope dir live_grep<cr>",     desc = '[S]earch by [G]rep in directory' },
      { '<leader>sh',      "<cmd>Telescope help_tags<cr>",         desc = '[S]earch [H]elp' },
      { '<leader>sr',      "<cmd>Telescope git_branches<cr>",      desc = '[S]earch git b[R]anches' },
      { '<leader>sw',      "<cmd>Telescope grep_string<cr>",       desc = '[S]earch current [W]ord' },
      { '<leader>sz',      "<cmd>Telescope zoxide list<cr>",       desc = '[S]earch [Z]oxide' },
      { '<leader>rs',      "<cmd>Telescope rails specs<cr>",       desc = '[R]ails [S]pecs' },
      { '<leader>rc',      "<cmd>Telescope rails controllers<cr>", desc = '[R]ails [C]ontrollers' },
      { '<leader>rm',      "<cmd>Telescope rails models<cr>",      desc = '[R]ails [M]odels' },
      { '<leader>rv',      "<cmd>Telescope rails views<cr>",       desc = '[R]ails [V]iews' },
      { '<leader>ri',      "<cmd>Telescope rails migrations<cr>",  desc = '[R]ails m[I]grations' },
      { '<leader>rl',      "<cmd>Telescope rails libs<cr>",        desc = '[R]ails [L]ibs' },
    },
    config = function(_, opts)
      local tele = require("telescope")
      tele.setup(opts)
      tele.load_extension("zoxide")
      tele.load_extension("rails")
    end,
  },


}

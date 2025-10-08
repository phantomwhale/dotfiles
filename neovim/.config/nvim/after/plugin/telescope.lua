local telescope_actions = require('telescope.actions')

-- Custom telescope finder functions
local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

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

-- Telescope keybinds
vim.keymap.set('n', '<leader>/', function()
  -- can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sF',
  require('telescope').extensions.dir.find_files, { desc = '[S]earch [F]iles in directory' })
vim.keymap.set('n', '<leader>sb', telescope_live_grep_open_files, { desc = '[S]earch open [B]uffers' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG',
  require('telescope').extensions.dir.live_grep, { desc = '[S]earch by [G]rep in directory' })
vim.keymap.set('n', '<leader>sz', require("telescope").extensions.zoxide.list, { desc = '[S]earch [Z]oxide' })
vim.keymap.set('n', '<leader>sc', telescope_pick_base16_color, { desc = '[S]earch [C]olour themes' })

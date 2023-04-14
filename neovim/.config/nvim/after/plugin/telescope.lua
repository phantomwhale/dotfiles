local status, telescope = pcall(require, "telescope")
if (not status) then return end
local telescope_actions = require('telescope.actions')

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
})

-- Telescope keybinds
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sz', require("telescope").extensions.zoxide.list, { desc = '[S]earch [Z]oxide' })

vim.keymap.set('n', '<leader>sc', function()
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
                notify_colorscheme_changes(name)
                telescope_actions.close(bufnr)
            end)
            telescope_action_set.shift_selection:enhance({
                post = function()
                    local name = telescope_action_state.get_selected_entry().value
                    vim.cmd('colorscheme '..name)
                end
            })
            return true
        end
    }):find()
end)

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension('fzf')

-- Load the zoxide plugin
require("telescope").load_extension('zoxide')

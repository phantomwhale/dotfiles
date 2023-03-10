-- this is our source of truth for colorschemes
local base16_theme_fname = vim.fn.expand(vim.env.HOME ..'/.base16_theme')

-- need to run the file updates async to avoid issues with keypresses not working
local Job = require "plenary.job"

function notify_colorscheme_changes(name)
    vim.fn.writefile({ name }, base16_theme_fname)
    vim.cmd('colorscheme '..name)

    -- !!! This seems to cause input issues at times
    --     Error seems to happen when hitting enter on the Telescope menu
    --     Can live with it for now; this is not a commonly used function
    job = Job:new({
        command = 'kitty',
        args = {
            '@',
            'set-colors',
            '-c',
            '-a',
            string.format(vim.env.HOME .. '/.config/base16-kitty/colors/%s.conf', name)
        }
    })
    job:sync()
end

vim.cmd('colorscheme ' .. vim.fn.readfile(base16_theme_fname)[1])

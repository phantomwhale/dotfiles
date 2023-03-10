-- this is our source of truth for colorschemes
local base16_theme_fname = vim.fn.expand(vim.env.HOME ..'/.base16_theme')

function notify_colorscheme_changes(name)
    vim.fn.writefile({ name }, base16_theme_fname)
    vim.cmd('colorscheme '..name)
    vim.loop.spawn('kitty', {
        args = {
            '@',
            'set-colors',
            '-c',
            '-a',
            string.format(vim.env.HOME .. '/.config/base16-kitty/colors/%s.conf', name)
        }
    }, nil)
end

vim.cmd('colorscheme ' .. vim.fn.readfile(base16_theme_fname)[1])

local opt = vim.opt

opt.autowrite = true -- ensure files are written when we call :make

-- indents
opt.smartindent = true -- Smart indenting for "C programs"
opt.smarttab = true    -- Use shiftwidth when inserting <Tab>
opt.shiftwidth = 2     -- Number of spaces to use in each autoindent step
opt.softtabstop = 2    -- Number of spaces to skip/insert when <BS> or <tab>ing
opt.tabstop = 2        -- <tab> uses width of two spaces
opt.expandtab = true   -- Use spaces, not tabs

-- line numbers
opt.number = true         -- show the actual line number
opt.relativenumber = true -- show other lines with relative line numbers
local numbertogglegroup = vim.api.nvim_create_augroup("numbertoggle", {})
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
  {
    pattern = "*",
    callback = function()
      if vim.api.nvim_get_mode() ~= "i" then
        opt.relativenumber = true
      end
    end,
    group = numbertogglegroup
  }
)
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
  {
    pattern = "*",
    command = 'if &number | set norelativenumber | endif',
    group = numbertogglegroup
  }
)

-- No swap files
opt.swapfile = false    -- no swap files
opt.backup = false      -- no backup files
opt.writebackup = false -- no write backup files

-- keep undo files instead
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Don't show the mode, since it's already in status line
opt.showmode = false

-- Vim commands
opt.cmdheight = 2                  -- better display for command messages
opt.wildmode = "list:longest,full" -- show all command matches on tab, select on second tab

opt.termguicolors = true

opt.scrolloff = 8 -- always keep 8 lines above/below cursor

-- Text search
opt.hlsearch = true   -- Highlight search after searching
opt.incsearch = true  -- Show incremental search highlight
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true  -- ...unless we type a capital

-- Sets how neovim will display certain whitespace in the editor.
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

opt.wrap = false -- no text wrapping by default

-- Show which line your cursor is on
opt.cursorline = true

-- Set completeopt to have a better completion experience
opt.completeopt = 'menuone,noselect'

-- Preview substitutions live, as you type - shows changes off-screen in a buffer
opt.inccommand = 'split'

-- folding
opt.foldmethod = "indent"
opt.foldenable = false

-- Keep signcolumn on by default
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

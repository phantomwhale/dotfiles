_G.global = {}

vim.g.mapleader = ","                 -- map , to leader; set this early to ensure other mappings use it

local opt = vim.opt

opt.autowrite = true                  -- ensure files are written when we call :make

-- indents
opt.smartindent = true                -- Smart indenting for "C programs"
opt.smarttab = true                   -- Use shiftwidth when inserting <Tab>
opt.shiftwidth = 2                    -- Number of spaces to use in each autoindent step
opt.softtabstop = 2                   -- Number of spaces to skip/insert when <BS> or <tab>ing
opt.tabstop = 2                       -- <tab> uses width of two spaces
opt.expandtab = true                  -- Use spaces, not tabs

-- line numbers
opt.number = true                     -- show the actual line number
opt.relativenumber = true             -- show other lines with relative line numbers

-- No swap files
opt.swapfile = false                  -- no swap files
opt.backup = false                    -- no backup files
opt.writebackup = false               -- no write backup files

-- Vim commands
opt.cmdheight = 2                     -- better display for command messages
opt.wildmode = "list:longest,full"    -- show all command matches on tab, select on second tab

-- Text search
opt.ignorecase = true                 -- Ignore case when searching...
opt.smartcase = true                  -- ...unless we type a capital"

opt.listchars = "tab:▸ ,extends:>,precedes:<"
opt.wrap = false                      -- no text wrapping by default

require('plugins')
require('lsp')

_G.global = {}

vim.g.mapleader = ","                 -- map , to leader; set this early to ensure other mappings use it

require('core/options')
require('plugins')
require('lsp')

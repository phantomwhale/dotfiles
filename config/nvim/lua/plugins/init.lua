local execute = vim.api.nvim_command

-- check if packer is installed (~/.local/share/nvim/site/pack)
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = install_path .. "/plugin/packer_compiled.lua"
local is_installed = vim.fn.empty(vim.fn.glob(install_path)) == 0

if not is_installed then
    if vim.fn.input("Install packer.nvim? (y for yes) ") == "y" then
        execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
        execute("packadd packer.nvim")
        print("Installed packer.nvim.")
        is_installed = 1
    end
end

-- Packer commands
vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]
vim.cmd [[command! PC PackerCompile]]
vim.cmd [[command! PS PackerStatus]]
vim.cmd [[command! PU PackerSync]]

local packer = nil
if not is_installed then return end
if packer == nil then
    packer = require('packer')
    packer.init({
        -- we don't want the compilation file in '~/.config/nvim'
        compile_path = compile_path
    })
end

local use = packer.use

-- Packer can manage itself
use 'wbthomason/packer.nvim'

-- LSP
use {'neovim/nvim-lspconfig'}  -- Collection of configurations for built-in LSP client
-- TODO: look into https://github.com/kabouzeid/nvim-lspinstall for installing LSPs
use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
use 'L3MON4D3/LuaSnip' -- Snippets plugin

-- Syntax plugins
use {'sheerun/vim-polyglot'} -- syntax highlights for 120 languages
use {'stephpy/vim-yaml'} -- yaml syntax highlights
-- use 'othree/javascript-libraries-syntax.vim'
-- use 'rhysd/vim-clang-format'

-- IDE plugins
use {'airblade/vim-rooter',
    config = function() -- Automatically set pwd when opening a file
        vim.g.rooter_patterns = {'.git/'}
    end
}
use {'psliwka/vim-smoothie'} -- smooth scrolling

-- Go
use {'fatih/vim-go', run = ':GoUpdateBinaries'}

-- Git
use {'airblade/vim-gitgutter'}
use {'tpope/vim-fugitive'}
use {'tpope/vim-rhubarb'}

-- Tim Pope basics
use {'tpope/vim-commentary'}
use {'tpope/vim-endwise'}
use {'tpope/vim-eunuch'}
use {'tpope/vim-obsession'}
use {'tpope/vim-repeat'}
use {'tpope/vim-surround'}
use {'tpope/vim-unimpaired'}
use {'tpope/vim-vinegar'}

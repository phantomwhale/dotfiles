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

-- Managed third-party packages
use {"williamboman/mason.nvim" , "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim"}

-- LSP
use {'neovim/nvim-lspconfig'}  -- Collection of configurations for built-in LSP client
-- TODO: look into https://github.com/kabouzeid/nvim-lspinstall for installing LSPs

-- Autocompletion
use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
use 'hrsh7th/cmp-buffer' -- Autocompletion from the buffer
use 'hrsh7th/cmp-path' -- Autocompletion for file paths
use 'hrsh7th/cmp-nvim-lua' -- Autocompletion for LUA, with nvim knowledge
use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
use 'onsails/lspkind.nvim' -- pictograms for neovim LSP

use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
use 'L3MON4D3/LuaSnip' -- Snippets plugin

use({'jose-elias-alvarez/null-ls.nvim', -- use neovim as a custom language server for diagnostics, code actions and more
    requires = {'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    'lewis6991/gitsigns.nvim'}
  })

use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate'
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- doesn't seem to work?
    disable = function(lang, bufnr) -- Disable in large Json buffers
      return lang == "json" and api.nvim_buf_line_count(bufnr) > 1000
    end,
  },
}

use { 'mitchellh/tree-sitter-proto' } -- tree-sitter grammer for proto3

-- Search
use {
  'nvim-telescope/telescope.nvim',
  requires = { 'nvim-lua/plenary.nvim' }
}
use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

-- Syntax plugins
use {'sheerun/vim-polyglot'} -- syntax highlights for 120 languages
use {'stephpy/vim-yaml'} -- yaml syntax highlights

-- IDE plugins
use {'airblade/vim-rooter',
  config = function() -- Automatically set pwd when opening a file
    vim.g.rooter_patterns = {'.git/'}
  end
}
use {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {}
  end
}

-- statusline and color scheme
use { 'nvim-lualine/lualine.nvim', requires = { 'RRethy/nvim-base16' } }

use {'psliwka/vim-smoothie'} -- smooth scrolling
use {'rizzatti/dash.vim'} -- add :Dash documentation lookup
use {'rking/ag.vim'} -- add :Ag file search
use {'junegunn/fzf', dir = '~/.fzf', run = './install --all'}
use {'ctrlpvim/ctrlp.vim'}
use {'excalios/vim-test'}
use {'majutsushi/tagbar'}
use {'Raimondi/delimitMate'} -- auto-complete quotes, parens, brackets
use {'vim-scripts/RelativeNumberCurrentWindow'} -- relative line numbers
use {'yssl/QFEnter'} -- control where to open QuickFix links
use {'kyazdani42/nvim-web-devicons'} -- devicons; requires a Nerd Font installation

-- Go
use {'fatih/vim-go', run = ':GoUpdateBinaries'}

-- Ruby
use {'vim-ruby/vim-ruby'}
use {'tpope/vim-rails'}
use {'thoughtbot/vim-rspec'}
use {'ruby-formatter/rufo-vim'} -- provides :Rufo for formatting
use {'ecomba/vim-ruby-refactoring', branch = 'main'}
use {'jgdavey/vim-blockle'} -- toggle block styles [do/end <-> {}]
use {'nelstrom/vim-textobj-rubyblock', requires = {'kana/vim-textobj-user'}}
use {'t9md/vim-ruby-xmpfilter'}
use {'tpope/vim-bundler'} -- bundle open, but inside a vim session

-- Javascript / Typescript
use {'ruanyl/vim-sort-imports',  -- adds :SortImports to js/ts files
  run = 'npm install -g import-sort-cli import-sort-parser-babylon ' ..
'import-sort-parser-typescript import-sort-style-renke'} -- TODO: move these into Mason
use {'jose-elias-alvarez/typescript.nvim'}
use {'pantharshit00/vim-prisma'} -- prisma formatting

-- Git
use {'lewis6991/gitsigns.nvim'}
--use {'airblade/vim-gitgutter'}
use {'tpope/vim-fugitive'}
use {'tpope/vim-rhubarb'}
use {'jkramer/vim-checkbox'} -- Markdown checkbox handling, for PR descriptions

-- Markdown
use {'iamcco/markdown-preview.nvim', -- adds :MarkdownPreview command
  opt = true,
  ft = { "markdown" },
  config = "vim.cmd[[doautocmd BufEnter]]",
  run = "cd app && yarn install",
  cmd = "MarkdownPreview",
}

-- PHP
use {'phpactor/phpactor', ft = 'php', run = 'composer install --no-dev -o'}

-- Tim Pope basics
use {'tpope/vim-abolish'}
use {'tpope/vim-commentary'}
use {'tpope/vim-dispatch'}
use {'tpope/vim-endwise'}
use {'tpope/vim-eunuch'}
use {'tpope/vim-obsession'}
use {'tpope/vim-ragtag'}
use {'tpope/vim-repeat'}
use {'tpope/vim-surround'}
use {'tpope/vim-unimpaired'}
use {'tpope/vim-vinegar'}

-- Writing
use {'junegunn/goyo.vim'} -- distraction free writing
use {'junegunn/limelight.vim'}

-- Misc
use {"nvim-lua/plenary.nvim"} -- required for plugins
use {"micarmst/vim-spellsync"} -- keep binary spelling file in sync with text file, and out of source control

-- Now require the other plugin lua files
require('plugins/nvim-cmp')
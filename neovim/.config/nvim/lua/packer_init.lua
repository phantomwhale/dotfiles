local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local ensure_packer = function()
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    print "Installing packer..."
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- we don't want the compilation file in '~/.config/nvim'
local compile_path = install_path .. "/plugin/packer_compiled.lua"

local packer = require('packer')
packer.init({
  compile_path = compile_path,
  max_jobs = 70 -- unlimited jobs seems to hit a MacOS file limit (ref: https://github.com/wbthomason/packer.nvim/issues/1199)
})
local use = packer.use

-- Packer can manage itself
use 'wbthomason/packer.nvim'

-- Managed third-party packages
use { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" }

-- Autocompletion
use 'hrsh7th/nvim-cmp'             -- Autocompletion plugin
use 'hrsh7th/cmp-buffer'           -- Autocompletion from the buffer
use 'hrsh7th/cmp-path'             -- Autocompletion for file paths
use 'L3MON4D3/LuaSnip'             -- Snippets plugin
use 'saadparwaiz1/cmp_luasnip'     -- Snippets source for nvim-cmp
use 'rafamadriz/friendly-snippets' -- Useful snippets
use 'hrsh7th/cmp-nvim-lua'         -- Autocompletion for LUA, with nvim knowledge
use 'onsails/lspkind.nvim'         -- pictograms for neovim LSP

use({
  'nvimtools/none-ls.nvim', -- use neovim as a custom language server for diagnostics, code actions and more
  requires = { 'nvim-lua/plenary.nvim',
    'neovim/nvim-lspconfig',
    'lewis6991/gitsigns.nvim' }
})

-- LSP
use { 'neovim/nvim-lspconfig' } -- Collection of configurations for built-in LSP client
use 'hrsh7th/cmp-nvim-lsp'      -- LSP source for nvim-cmp

-- Highlight, edit and navigate code
use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate'
}

use { "nvim-treesitter/nvim-treesitter-textobjects",
  after = "nvim-treesitter",
  requires = "nvim-treesitter/nvim-treesitter",
}

use { "RRethy/nvim-treesitter-endwise" }

use { 'mitchellh/tree-sitter-proto' } -- tree-sitter grammer for proto3

-- Search
use {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  requires = { { 'nvim-lua/plenary.nvim' } }
}
use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
use { 'nvim-tree/nvim-web-devicons' } -- devicons; requires a Nerd Font installation
use { 'jvgrootveld/telescope-zoxide' }

-- Syntax plugins
use { 'stephpy/vim-yaml' }               -- yaml syntax highlights
use { 'ntpeters/vim-better-whitespace' } -- show trailing whitespace

-- IDE plugins
use { 'stevearc/dressing.nvim' }
use { 'airblade/vim-rooter',
  config = function() -- Automatically set pwd when opening a file
    vim.g.rooter_patterns = { '.git/' }
    vim.g.rooter_targets = { '!^phantom-press' }
  end
}
--use {
--"folke/which-key.nvim",
--config = function()
--require("which-key").setup {}
--end
--}

-- colorscheme
use { 'tinted-theming/base16-vim' }
-- statusline
use { 'nvim-lualine/lualine.nvim',
  requires = {
    { 'nvim-tree/nvim-web-devicons', opt = true },
    { 'tinted-theming/base16-vim' }
  }
}

use { 'psliwka/vim-smoothie' } -- smooth scrolling
use { 'rizzatti/dash.vim' }    -- add :Dash documentation lookup
use { 'rking/ag.vim' }         -- add :Ag file search
use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
use { 'ctrlpvim/ctrlp.vim' }
use { 'excalios/vim-test' }
use { 'majutsushi/tagbar' }
use { 'Raimondi/delimitMate' }                    -- auto-complete quotes, parens, brackets
use { 'vim-scripts/RelativeNumberCurrentWindow' } -- relative line numbers
use { 'yssl/QFEnter' }                            -- control where to open QuickFix links

-- testing
-- current set up for rspec only
use {
  "nvim-neotest/neotest",
  requires = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec"
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec"),
      }
    })
  end
}

-- Go
-- use {'fatih/vim-go', run = ':GoUpdateBinaries'}
use 'ray-x/go.nvim'
use 'ray-x/guihua.lua' -- recommended if need floating window support

-- Ruby
use { 'tpope/vim-rails' }
use { 'thoughtbot/vim-rspec' }
use { 'ruby-formatter/rufo-vim' } -- provides :Rufo for formatting
use { 'ecomba/vim-ruby-refactoring', branch = 'main' }
use { 'jgdavey/vim-blockle' }     -- toggle block styles [do/end <-> {}]
use { 'nelstrom/vim-textobj-rubyblock', requires = { 'kana/vim-textobj-user' } }
use { 't9md/vim-ruby-xmpfilter' }
use { 'tpope/vim-bundler' } -- bundle open, but inside a vim session

-- Javascript / Typescript
use { 'ruanyl/vim-sort-imports',                                -- adds :SortImports to js/ts files
  run = 'npm install -g import-sort-cli import-sort-parser-babylon ' ..
      'import-sort-parser-typescript import-sort-style-renke' } -- TODO: move these into Mason
use { 'jose-elias-alvarez/typescript.nvim' }
use { 'pantharshit00/vim-prisma' }                              -- prisma formatting

-- Git
use { 'lewis6991/gitsigns.nvim' }
--use {'airblade/vim-gitgutter'}
use { 'tpope/vim-fugitive' }
use { 'shumphrey/fugitive-gitlab.vim' }
use { 'tpope/vim-rhubarb' }
use { 'jkramer/vim-checkbox' }            -- Markdown checkbox handling, for PR descriptions
use { 'knsh14/vim-github-link' }          -- Quickly copy URL for commits and branches
use { 'cwebster2/github-coauthors.nvim' } -- Telescope plug-in for git co-authors

-- Markdown
use { 'iamcco/markdown-preview.nvim', -- adds :MarkdownPreview command
  opt = true,
  ft = { "markdown" },
  config = "vim.cmd[[doautocmd BufEnter]]",
  run = "cd app && yarn install",
  cmd = "MarkdownPreview",
}
use { "ellisonleao/glow.nvim" }
use({ 'toppair/peek.nvim', run = 'deno task --quiet build:fast' })

-- PHP
use { 'phpactor/phpactor', ft = 'php', run = 'composer install --no-dev -o' }

-- Tim Pope basics
use { 'tpope/vim-abolish' }
use { 'tpope/vim-characterize' }
use { 'tpope/vim-commentary' }
use { 'tpope/vim-dispatch' }
use { 'tpope/vim-eunuch' }
use { 'tpope/vim-obsession' }
use { 'tpope/vim-ragtag' }
use { 'tpope/vim-repeat' }
use { 'tpope/vim-rsi' }
use { 'tpope/vim-surround' }
use { 'tpope/vim-unimpaired' }

-- Directory exploration
use { "stevearc/oil.nvim" }

-- Aligning things
use { 'junegunn/vim-easy-align' }

-- Writing
use { 'junegunn/goyo.vim' } -- distraction free writing
use { 'junegunn/limelight.vim' }

use({
  "epwalsh/obsidian.nvim",
  tag = "*", -- recommended, use latest release instead of latest commit
  requires = {
    "nvim-lua/plenary.nvim"
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "personal",
          path = "~/GoogleDrive/Obsidian",
        },
      }
    })
  end
})

-- Misc
use { "nvim-lua/plenary.nvim" }     -- required for plugins
use { "micarmst/vim-spellsync" }    -- keep binary spelling file in sync with text file, and out of source control
use { 'aymericbeaumet/vim-symlink', -- follow symlinks, to help fugitive work on symlinked dotfiles
  requires = { 'moll/vim-bbye' }
}

use {
  'mikesmithgh/kitty-scrollback.nvim',
  disable = false,
  opt = true,
  cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
  event = { 'User KittyScrollbackLaunch' },
  -- tag = '*', -- latest stable version, may have breaking changes if major version changed
  -- tag = 'v4.0.0', -- pin specific tag
  config = function()
    require('kitty-scrollback').setup()
  end,
}

if packer_bootstrap then
  print "Syncing packer..."
  packer.sync()
end

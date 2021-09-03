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
use {'chriskempson/base16-vim'} -- use base16 colorschemes
use {'psliwka/vim-smoothie'} -- smooth scrolling
use {'vim-airline/vim-airline'} -- superpowered status bar
use {'vim-airline/vim-airline-themes'} -- adds base16 theme for airline
use {'rizzatti/dash.vim'} -- add :Dash documentation lookup
use {'rking/ag.vim'} -- add :Ag file search
use {'junegunn/fzf', dir = '~/.fzf', run = './install --all'}
use {'ctrlpvim/ctrlp.vim'}
use {'vim-test/vim-test'}
use {'majutsushi/tagbar'}
use {'Raimondi/delimitMate'} -- auto-complete quotes, parens, brackets
use {'vim-scripts/RelativeNumberCurrentWindow'} -- relative line numbers
use {'yssl/QFEnter'} -- control where to open QuickFix links

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

-- Javascript / Typescript
use {'ruanyl/vim-sort-imports',  -- adds :SortImports to js/ts files
      run = 'npm install -g import-sort-cli import-sort-parser-babylon ' ..
          'import-sort-parser-typescript import-sort-style-renke'}

-- Git
use {'airblade/vim-gitgutter'}
use {'tpope/vim-fugitive'}
use {'tpope/vim-rhubarb'}

-- Markdown
use {'iamcco/markdown-preview.nvim', -- adds :MarkdownPreview command
     run = function() vim.fn['mkdp#util#install'](0) end,
     cmd = 'MarkdownPreview'}

-- Tim Pope basics
use {'tpope/vim-commentary'}
use {'tpope/vim-dispatch'}
use {'tpope/vim-endwise'}
use {'tpope/vim-eunuch'}
use {'tpope/vim-obsession'}
use {'tpope/vim-repeat'}
use {'tpope/vim-surround'}
use {'tpope/vim-unimpaired'}
use {'tpope/vim-vinegar'}

-- Writing

use {'junegunn/goyo.vim'} -- distraction free writing
use {'junegunn/limelight.vim'}

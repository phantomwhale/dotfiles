-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Managed third-party packages
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'WhoIsSethDaniel/mason-tool-installer.nvim',

  -- Autocompletion
  'hrsh7th/nvim-cmp',             -- Autocompletion plugin
  'hrsh7th/cmp-buffer',           -- Autocompletion from the buffer
  'hrsh7th/cmp-path',             -- Autocompletion for file paths
  'L3MON4D3/LuaSnip',             -- Snippets plugin
  'saadparwaiz1/cmp_luasnip',     -- Snippets source for nvim-cmp
  'rafamadriz/friendly-snippets', -- Useful snippets
  'hrsh7th/cmp-nvim-lua',         -- Autocompletion for LUA, with nvim knowledge
  'onsails/lspkind.nvim',         -- pictograms for neovim LSP

  {
    'nvimtools/none-ls.nvim', -- use neovim as a custom language server for diagnostics, code actions and more
    dependencies = { 'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
      'lewis6991/gitsigns.nvim' }
  },

  -- LSP
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  'hrsh7th/cmp-nvim-lsp',  -- LSP source for nvim-cmp

  -- Highlight, edit and navigate code
  { 'nvim-treesitter/nvim-treesitter',             build = ':TSUpdate' },
  { "nvim-treesitter/nvim-treesitter-textobjects", dependencies = "nvim-treesitter/nvim-treesitter", },
  { "RRethy/nvim-treesitter-endwise" },
  { 'mitchellh/tree-sitter-proto' }, -- tree-sitter grammer for proto3

  -- Search
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    'princejoogie/dir-telescope.nvim',
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  'nvim-tree/nvim-web-devicons', -- devicons; requires a Nerd Font installation
  'jvgrootveld/telescope-zoxide',

  -- Syntax plugins
  'stephpy/vim-yaml',               -- yaml syntax highlights
  'ntpeters/vim-better-whitespace', -- show trailing whitespace

  -- IDE plugins
  'stevearc/dressing.nvim',
  {
    'airblade/vim-rooter',
    config = function() -- Automatically set pwd when opening a file
      vim.g.rooter_patterns = { '.git/' }
      vim.g.rooter_targets = { '!^phantom-press' }
    end
  },
  --{
  --"folke/which-key.nvim",
  --config = function()
  --require("which-key").init {}
  --end
  --},

  -- colorscheme
  'tinted-theming/tinted-vim',

  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', lazy = true },
      { 'tinted-theming/tinted-vim' }
    }
  },

  'psliwka/vim-smoothie', -- smooth scrolling
  'rizzatti/dash.vim',    -- add :Dash documentation lookup
  'rking/ag.vim',         -- add :Ag file search
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  'ctrlpvim/ctrlp.vim',
  'excalios/vim-test',
  'majutsushi/tagbar',
  'Raimondi/delimitMate', -- auto-complete quotes, parens, brackets
  'yssl/QFEnter',         -- control where to open QuickFix links

  -- testing
  -- current set up for rspec only
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec"
    }
  },


  -- Go
  -- {'fatih/vim-go', build = ':GoUpdateBinaries'},
  'ray-x/go.nvim',
  'ray-x/guihua.lua', -- recommended if need floating window support

  -- Ruby
  'tpope/vim-rails',
  'thoughtbot/vim-rspec',
  'ruby-formatter/rufo-vim', -- provides :Rufo for formatting
  'ecomba/vim-ruby-refactoring',
  branch = 'main',
  'jgdavey/vim-blockle', -- toggle block styles [do/end <-> {}]
  { 'nelstrom/vim-textobj-rubyblock',           dependencies = { 'kana/vim-textobj-user' } },
  't9md/vim-ruby-xmpfilter',
  'tpope/vim-bundler', -- bundle open, but inside a vim session

  -- Javascript / Typescript
  {
    'ruanyl/vim-sort-imports', -- adds :SortImports to js/ts files
    build = 'npm install -g import-sort-cli import-sort-parser-babylon ' ..
        'import-sort-parser-typescript import-sort-style-renke'
  },                          -- TODO: move these into Mason
  'jose-elias-alvarez/typescript.nvim',
  'pantharshit00/vim-prisma', -- prisma formatting

  -- Git
  'lewis6991/gitsigns.nvim',
  --'airblade/vim-gitgutter',
  'tpope/vim-fugitive',
  'shumphrey/fugitive-gitlab.vim',
  'tpope/vim-rhubarb',
  'jkramer/vim-checkbox',            -- Markdown checkbox handling, for PR descriptions
  'knsh14/vim-github-link',          -- Quickly copy URL for commits and branches
  'cwebster2/github-coauthors.nvim', -- Telescope plug-in for git co-authors

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  "ellisonleao/glow.nvim",
  { 'toppair/peek.nvim', build = 'deno task --quiet build:fast' },

  -- PHP
  { 'phpactor/phpactor', ft = 'php',                            build = 'composer install --no-dev -o' },

  -- Tim Pope basics
  'tpope/vim-abolish',
  'tpope/vim-characterize',
  'tpope/vim-commentary',
  'tpope/vim-dispatch',
  'tpope/vim-eunuch',
  'tpope/vim-obsession',
  'tpope/vim-ragtag',
  'tpope/vim-repeat',
  'tpope/vim-rsi',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',

  -- Directory exploration
  "stevearc/oil.nvim",

  -- Aligning things
  'junegunn/vim-easy-align',

  -- Writing
  'junegunn/goyo.vim', -- distraction free writing
  'junegunn/limelight.vim',

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    event = {
      "BufReadPre " .. vim.fn.expand "~" .. "/GoogleDrive/Obsidian/*.md",
      "BufNewFile " .. vim.fn.expand "~" .. "/GoogleDrive/Obsidian/*.md",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/GoogleDrive/Obsidian",
        },
      },
    },
  },

  -- Misc
  "nvim-lua/plenary.nvim",        -- required for plugins
  "micarmst/vim-spellsync",       -- keep binary spelling file in sync with text file, and out of source control
  {
    'aymericbeaumet/vim-symlink', -- follow symlinks, to help fugitive work on symlinked dotfiles
    dependencies = { 'moll/vim-bbye' }
  },

  -- Use Neovim for scrollback buffer in Kitty
  {
    'mikesmithgh/kitty-scrollback.nvim',
    enabled = true,
    lazy = true,
    cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
    event = { 'User KittyScrollbackLaunch' },
    config = function()
      require('kitty-scrollback').setup()
    end,
  }
})

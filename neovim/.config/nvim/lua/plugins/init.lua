return {
  -- Autocompletion
  'hrsh7th/nvim-cmp',             -- Autocompletion plugin
  'hrsh7th/cmp-buffer',           -- Autocompletion from the buffer
  'hrsh7th/cmp-path',             -- Autocompletion for file paths
  'L3MON4D3/LuaSnip',             -- Snippets plugin
  'saadparwaiz1/cmp_luasnip',     -- Snippets source for nvim-cmp
  'rafamadriz/friendly-snippets', -- Useful snippets
  'hrsh7th/cmp-nvim-lua',         -- Autocompletion for LUA, with nvim knowledge
  'onsails/lspkind.nvim',         -- pictograms for neovim LSP

  -- LSP
  'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp

  -- Search
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

  -- 'psliwka/vim-smoothie', -- smooth scrolling
  'rizzatti/dash.vim', -- add :Dash documentation lookup
  'rking/ag.vim',      -- add :Ag file search
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


  -- Go
  -- {'fatih/vim-go', build = ':GoUpdateBinaries'},
  'ray-x/go.nvim',
  'ray-x/guihua.lua', -- recommended if need floating window support

  -- Ruby
  'tpope/vim-rails',
  'thoughtbot/vim-rspec',
  'ruby-formatter/rufo-vim', -- provides :Rufo for formatting
  'ecomba/vim-ruby-refactoring',
  'jgdavey/vim-blockle',     -- toggle block styles [do/end <-> {}]
  {
    'nelstrom/vim-textobj-rubyblock',
    dependencies = { 'kana/vim-textobj-user' }
  },
  't9md/vim-ruby-xmpfilter',
  'tpope/vim-bundler', -- bundle open, but inside a vim session

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
  { 'toppair/peek.nvim',                        build = 'deno task --quiet build:fast' },

  -- PHP
  {
    'phpactor/phpactor',
    ft = 'php',
    build = 'composer install --no-dev -o'
  },

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

  -- Aligning things
  'junegunn/vim-easy-align',

  -- Writing
  'junegunn/goyo.vim', -- distraction free writing
  'junegunn/limelight.vim',

  -- Misc
  "nvim-lua/plenary.nvim",        -- required for plugins
  "micarmst/vim-spellsync",       -- keep binary spelling file in sync with text file, and out of source control
  {
    'aymericbeaumet/vim-symlink', -- follow symlinks, to help fugitive work on symlinked dotfiles
    dependencies = { 'moll/vim-bbye' }
  },
}

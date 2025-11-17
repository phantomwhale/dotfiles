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

  -- Syntax plugins
  'ntpeters/vim-better-whitespace', -- show trailing whitespace

  -- IDE plugins
  {
    'airblade/vim-rooter',
    config = function() -- Automatically set pwd when opening a file
      vim.g.rooter_patterns = { '.git/' }
      vim.g.rooter_targets = { '!^phantom-press' }
    end
  },

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
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  'excalios/vim-test',
  'majutsushi/tagbar',
  'Raimondi/delimitMate', -- auto-complete quotes, parens, brackets

  -- Ruby
  'tpope/vim-rails',
  'thoughtbot/vim-rspec',
  'ecomba/vim-ruby-refactoring',
  'jgdavey/vim-blockle', -- toggle block styles [do/end <-> {}]
  {
    'nelstrom/vim-textobj-rubyblock',
    dependencies = { 'kana/vim-textobj-user' }
  },
  'tpope/vim-bundler', -- bundle open, but inside a vim session

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'jkramer/vim-checkbox',            -- Markdown checkbox handling, for PR descriptions
  'knsh14/vim-github-link',          -- Quickly copy URL for commits and branches
  'cwebster2/github-coauthors.nvim', -- Telescope plug-in for git co-authors

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
  { 'junegunn/goyo.vim', cmd = "Goyo" }, -- distraction free writing
  'junegunn/limelight.vim',

  -- Misc
  "nvim-lua/plenary.nvim",        -- required for plugins
  "micarmst/vim-spellsync",       -- keep binary spelling file in sync with text file, and out of source control
  {
    'aymericbeaumet/vim-symlink', -- follow symlinks, to help fugitive work on symlinked dotfiles
    dependencies = { 'moll/vim-bbye' }
  },
}

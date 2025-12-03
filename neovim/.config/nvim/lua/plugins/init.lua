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

  -- 'psliwka/vim-smoothie', -- smooth scrolling
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    opts = {}
  },
  {
    'excalios/vim-test',
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
  },

  -- Ruby
  {
    'tpope/vim-rails',
    ft = { "ruby", "eruby" },
  },
  {
    'thoughtbot/vim-rspec',
    ft = "ruby",
  },
  {
    'ecomba/vim-ruby-refactoring',
    ft = "ruby",
  },
  {
    'jgdavey/vim-blockle', -- toggle block styles [do/end <-> {}]
    ft = "ruby",
  },
  {
    'nelstrom/vim-textobj-rubyblock',
    ft = "ruby",
    dependencies = { 'kana/vim-textobj-user' }
  },
  {
    'tpope/vim-bundler', -- bundle open, but inside a vim session
    lazy = false,
    dependencies = { 'tpope/vim-rails' },
  },

  -- Git (fugitive is in its own file)
  {
    'jkramer/vim-checkbox', -- Markdown checkbox handling, for PR descriptions
    ft = "markdown",
  },
  -- Tim Pope basics
  'tpope/vim-abolish',
  {
    'tpope/vim-characterize',
    keys = { { "gA", "<Plug>(characterize)", desc = "Characterize" } },
  },
  'tpope/vim-commentary',
  {
    'tpope/vim-dispatch',
    cmd = { "Dispatch", "Make", "Focus", "Start", "Spawn" },
  },
  {
    'tpope/vim-eunuch',
    cmd = { "Delete", "Move", "Rename", "Chmod", "Mkdir", "SudoWrite", "SudoEdit" },
  },
  {
    'tpope/vim-obsession',
    cmd = "Obsession",
  },
  'tpope/vim-repeat',
  'tpope/vim-rsi',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',

  -- Aligning things
  {
    'junegunn/vim-easy-align',
    keys = {
      { "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "Easy Align" },
    },
  },

  -- Writing
  {
    'junegunn/limelight.vim',
    cmd = "Limelight",
  },

  -- Misc
  "micarmst/vim-spellsync",       -- keep binary spelling file in sync with text file, and out of source control
  {
    'aymericbeaumet/vim-symlink', -- follow symlinks, to help fugitive work on symlinked dotfiles
    dependencies = { 'moll/vim-bbye' }
  },
}

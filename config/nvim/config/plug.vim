call plug#begin('~/.config/nvim/plugged')

" Plugs go here

" Syntax highlighting and formatting
Plug 'sheerun/vim-polyglot'
"Plug 'othree/javascript-libraries-syntax.vim'
"Plug 'rhysd/vim-clang-format'
Plug 'stephpy/vim-yaml'

" git tooling
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Go tooling
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" superpowered status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Smooth scrolling
Plug 'psliwka/vim-smoothie'

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Save IDE sessions

" ruby formatting
Plug 'ruby-formatter/rufo-vim'

Plug 'scrooloose/vim-slumlord'
" Run tests in a separate terminal
Plug 'janko/vim-test'
Plug 'dbakker/vim-projectroot'

Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ecomba/vim-ruby-refactoring', { 'branch': 'main' }
Plug 'honza/vim-snippets'
Plug 'jgdavey/vim-blockle'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'rstacruz/sparkup'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'kana/vim-textobj-user' " dependancy
Plug 'Raimondi/delimitMate'
Plug 'rizzatti/dash.vim'
Plug 'rking/ag.vim'
Plug 't9md/vim-ruby-xmpfilter'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/RelativeNumberCurrentWindow'
Plug 'yssl/QFEnter'

Plug 'junegunn/goyo.vim'  "distraction free writing
Plug 'junegunn/limelight.vim'

" JS/TS import organiser
Plug 'ruanyl/vim-sort-imports', { 'do': 'npm install -g import-sort-cli import-sort-parser-babylon import-sort-parser-typescript import-sort-style-renke' }

call plug#end()

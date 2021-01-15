call plug#begin('~/.vim/plugged')

" Plugs go here

" Syntax highlighting and formatting
Plug 'aklt/plantuml-syntax'
Plug 'evidens/vim-twig'
Plug 'jelera/vim-javascript-syntax'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'rhysd/vim-clang-format'
Plug 'sheerun/vim-polyglot'
Plug 'stephpy/vim-yaml'

" git tooling
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Go tooling
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" CoC completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}

" superpowered status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Smooth scrolling
Plug 'psliwka/vim-smoothie'

" ruby formatting
Plug 'ruby-formatter/rufo-vim'

Plug 'scrooloose/vim-slumlord'
" Run tests in a separate terminal
Plug 'janko/vim-test'
Plug 'dbakker/vim-projectroot'

Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ecomba/vim-ruby-refactoring'
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
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/RelativeNumberCurrentWindow'
Plug 'yssl/QFEnter'

Plug 'junegunn/goyo.vim'  "distraction free writing
Plug 'junegunn/limelight.vim'

call plug#end()

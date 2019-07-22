call plug#begin('~/.vim/plugged')

" Plugs go here

" Syntax highlighting and formatting
Plug 'aklt/plantuml-syntax'
Plug 'evidens/vim-twig'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jelera/vim-javascript-syntax'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'rhysd/vim-clang-format'

" Language Severs
Plug 'w0rp/ale'

Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'chriskempson/base16-vim'
" Oh noes! The PR to fix up this for nvim was deleted. Have forked locally.
Plug 'phantomwhale/vim-tmux-navigator', { 'branch': 'indicator' }
"Plug 'christoomey/vim-tmux-navigator', { 'branch': 'indicator' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'honza/vim-snippets'
Plug 'jgdavey/vim-blockle'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'ludovicchabant/vim-gutentags'
"Plug 'kana/vim-textobj-user'
Plug 'majutsushi/tagbar'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'rstacruz/sparkup'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'kana/vim-textobj-user' " dependancy
Plug 'OmniSharp/omnisharp-vim', { 'do': 'cd server && xbuild' }
Plug 'Raimondi/delimitMate'
Plug 'rizzatti/dash.vim'
Plug 'rking/ag.vim'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 't9md/vim-ruby-xmpfilter'
Plug 'thoughtbot/vim-rspec'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --tern-completer --gocode-completer
  endif
endfunction
" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/RelativeNumberCurrentWindow'
Plug 'yssl/QFEnter'

" Dark powered asynchronous completion framework for neovim/Vim8
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'zchee/deoplete-go', { 'do': 'make' }

call plug#end()

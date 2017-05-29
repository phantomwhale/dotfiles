call plug#begin('~/.vim/plugged')

" Plugs go here

" Syntax highlighting
Plug 'evanmiller/nginx-vim-syntax'
Plug 'evidens/vim-twig'
Plug 'fatih/vim-go'
Plug 'jelera/vim-javascript-syntax'
Plug 'mxw/vim-jsx'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'

Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'honza/vim-snippets'
Plug 'jgdavey/vim-blockle'
"Plug 'kana/vim-textobj-user'
Plug 'majutsushi/tagbar'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'rstacruz/sparkup'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'kana/vim-textobj-user' " dependancy
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
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/RelativeNumberCurrentWindow'

call plug#end()

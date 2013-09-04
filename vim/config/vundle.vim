filetype off                  " required by vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let vundle manage vundle
Bundle 'gmarik/vundle'

" Declare other vundles here
" Bundle 'astashov/vim-ruby-debugger'
" Bundle 'jgdavey/tslime.vim'
Bundle 'msanders/snipmate.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'thoughtbot/vim-rspec'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/RelativeNumberCurrentWindow'
Bundle 'wincent/Command-T'

filetype plugin indent on     " required

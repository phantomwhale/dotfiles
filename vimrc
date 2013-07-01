" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off    "required by vundle

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup
set nowritebackup
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Switch wrap off for everything
set nowrap

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'thoughtbot/vim-rspec'

filetype plugin indent on

"Set the Leader key to ','
let mapleader = ","

"Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

set relativenumber      " relative line numbers
set fileencodings=utf-8,iso-8859-1

"Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>

"Quick escape using 'jk' combination
imap jk <Esc>          

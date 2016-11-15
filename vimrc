" this is VIM country!!!
set nocompatible

" ============ General Config ============
set relativenumber              " relative line numbers
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=1000                " number of lines of command line history to store
set showcmd		                  " display incomplete commands
set showmode		                " display current mode
set autoread                    " Reload files changed outside of vim
set hidden                      " allow hidden buffers

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Set leader to a comma, becuase backslash is TOO far away
let mapleader = ","

" ============ Plug ============
let $CONFIG = "$HOME/.vim/config"
source $CONFIG/plug.vim

" ============ Turn off Swap Files ============
set noswapfile
set nobackup
set nowritebackup

" ============ Persistant Undo ============

if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ============ Indentation ============
set autoindent
set smartindent
set smarttab
set shiftwidth=2                  " Number of spaces to use in each autoindent step
set softtabstop=2                 " Number of spaces to skip/insert when <BS> or <tab>ing
set tabstop=2                     " <tab> uses width of two spaces
set expandtab                     " Use spaces, not tabs

" Auto indent pasted text
noremap p p=`]<C-o>
noremap P P=`]<C-o>

" ============ File types ============
" Let file types decide their plugin and indent settings
filetype plugin on
filetype indent on

" Allow local .vimrc overrides
set exrc

" Get our colours right
set t_Co=256
set background=dark
let base16colorspace=256
colorscheme base16-monokai
hi MatchParen cterm=bold

" make incomplete lines and tabs visible
set listchars=tab:▸\ ,extends:>,precedes:<

" ============ Folds ============
set foldmethod=indent       " fold based on indentation
set nofoldenable            " dont fold by default

" ============ Completion ============
set wildmode=list:longest
set wildmenu                " enables <C-n> and <C-p> to scroll matches

" ============ Search =============
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital"

" ============ Status Bar  =============
" Always show the status bar
set laststatus=2
" Put git branch in the status bar
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Switch wrap off for everything
set nowrap

" show the cursor position all the time
set ruler

" Lets allow mouse scrolling, because it's the 21st centuary after all
set mouse=a

" ============ Config files  =============
source $CONFIG/pluginconfig.vim
source $CONFIG/rails_test.vim
source $CONFIG/keybinds.vim

" ============ Autocommands =============
if has("autocmd")
  " auto-reload on .vimrc changes
  autocmd BufWritePost .vimrc so $MYVIMRC

  " Four tabs for JS, HTML and ERB
  autocmd FileType html setlocal shiftwidth=4 tabstop=4
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType eruby setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType php setlocal ts=4 sts=4 sw=4 expandtab

  " Autosave when we lose focus, just like Rubymine does
  autocmd BufLeave,FocusLost * silent! wall

  " Highlight debugging lines
  autocmd FileType ruby syn match error contained "\<binding.pry\>"
  autocmd FileType lua syn match error contained "\<Debug.chat\>"
  autocmd FileType lua syn match error contained "\<Debug.console\>"

  " Trailing whitespace
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()

  " spellcheck on markdown and git commits
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd FileType gitcommit setlocal spell

  " Remove trailing whitespace on save (Ruby only)
  function! TrimWhiteSpace()
    %s/\s\+$//e
  endfunction
  autocmd BufWritePre     *.rb,*.lua :call TrimWhiteSpace()

  " syntax highlighting for the forgotten ruby files
  au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
end

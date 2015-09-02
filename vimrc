let $CONFIG = "$HOME/.vim/config"

" this is VIM country!!!
set nocompatible

" Set leader
let mapleader = ","

"source $CONFIG/misc.vim
source $CONFIG/vundle.vim
source $CONFIG/editing.vim
"source $CONFIG/colors.vim
source $CONFIG/pluginconfig.vim
source $CONFIG/filetypes.vim
source $CONFIG/rails_test.vim
source $CONFIG/keybinds.vim

set backspace=2                " allow backspacing over everything in insert mode

set nobackup
set noswapfile                 " no annoying .swp files
set nowritebackup
set history=50                 " keep 50 lines of command line history
set ruler		                   " show the cursor position all the time
set showcmd		                 " display incomplete commands
set incsearch		               " do incremental searching
"set hidden                     " allow hidden buffers

set listchars=extends:>,precedes:<   " make incomplete lines visible

"Tab complete settings
set wildmode=longest,list,full
set wildmenu

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Get our colours right
set t_Co=256
set background=dark
let base16colorspace=256
colorscheme base16-railscasts
hi MatchParen cterm=bold

" Lets allow mouse scrolling, because it's the 21st centuary after all
set ttymouse=sgr " modern mouse handing
set mouse=a

" Switch wrap off for everything
set nowrap
set relativenumber      " relative line numbers

" let there be folding
set foldmethod=indent
set nofoldenable

" Always show the status bar
set laststatus=2
" Put git branch in the status bar
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" use system clipboard
set clipboard=unnamed

" Autocommands
if has("autocmd")
  " auto-reload on .vimrc changes
  autocmd BufWritePost .vimrc so $MYVIMRC

  " Four tabs for JS and ERB
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType eruby setlocal ts=4 sts=4 sw=4 expandtab

  " Autosave when we lose focus, just like Rubymine does
  autocmd BufLeave,FocusLost * silent! wall

  " Trailing whitespace
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()

  " Remove trailing whitespace on save (Ruby only)
  function! TrimWhiteSpace()
    %s/\s\+$//e
  endfunction
  autocmd BufWritePre     *.rb,*.lua :call TrimWhiteSpace()

  " syntax highlighting for the forgotten ruby files
  au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
end

let $CONFIG = "$HOME/.vim/config"

" this is VIM country!!!
set nocompatible

" Set leader
let mapleader = ","

"source $CONFIG/misc.vim
source $CONFIG/vundle.vim
source $CONFIG/editing.vim
"source $CONFIG/colors.vim
"source $CONFIG/pluginconfig.vim
"source $CONFIG/filetypes.vim
"source $CONFIG/functions.vim
source $CONFIG/keybinds.vim

set backspace=2                " allow backspacing over everything in insert mode

set nobackup
set noswapfile                 " no annoying .swp files
set nowritebackup
set history=50                 " keep 50 lines of command line history
set ruler		                   " show the cursor position all the time
set showcmd		                 " display incomplete commands
set incsearch		               " do incremental searching
set hidden                     " allow hidden buffers

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
set background=dark
set t_Co=256
let base16colorspace=256
colorscheme base16-railscasts
"colorscheme railscasts
hi MatchParen cterm=bold

" Switch wrap off for everything
set nowrap
set relativenumber      " relative line numbers

" let there be folding
set foldmethod=indent
set nofoldenable

let g:rspec_command = "Dispatch rspec {spec}"

match ErrorMsg '\s\+$'

"Autocommands
if has("autocmd")
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab

  "Autosave when we lose focus, just like Rubymine does
  autocmd BufLeave,FocusLost * silent! wall
end

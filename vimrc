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
set nowritebackup
set history=50                 " keep 50 lines of command line history
set ruler		                   " show the cursor position all the time
set showcmd		                 " display incomplete commands
set incsearch		               " do incremental searching

"Tab complete settings
set wildmode=longest,list,full
set wildmenu

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Switch wrap off for everything
set nowrap

set relativenumber      " relative line numbers

"Quick escape using 'jk' combination
imap jk <Esc>          

"Rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>

"Autocommands
if has("autocmd")
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab

  "Autosave when we lose focus, just like Rubymine does
  autocmd BufLeave,FocusLost * silent! wall
end

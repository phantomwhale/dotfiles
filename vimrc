let $CONFIG = "$HOME/.vim/config"

" this is VIM country!!!
set nocompatible

" Set leader
let mapleader = ","

let g:ruby_debugger_create_default_mappings = 0

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
set mouse=nicr

" Switch wrap off for everything
set nowrap
set relativenumber      " relative line numbers

" let there be folding
set foldmethod=indent
set nofoldenable

" we'll need an interactive shell if we want to execute our custom bash script command
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

match ErrorMsg '\s\+$'

" Quick editing
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e $MYVIMRC<cr>
nnoremap <leader>et <C-w>s<C-w>j<C-w>L:e ~/.tmux.conf<cr>
nnoremap <leader>eb <C-w>s<C-w>j<C-w>L:e $CONFIG/vundle.vim<cr>

"Autocommands
if has("autocmd")
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab

  "Autosave when we lose focus, just like Rubymine does
  autocmd BufLeave,FocusLost * silent! wall
end

" Always show the status bar
set laststatus=2
" Put git branch in the status bar
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


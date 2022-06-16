" ============ General Config ============
set showmode		        " display current mode
set autowrite                   " ensure files are written when we call :make
set nofsync                     " fsync causes vim to hang when closing https://github.com/ludovicchabant/vim-gutentags/issues/167#issuecomment-564889922

" Use hybrid line numbers; relative numbering for all lines except the current
" Also turn off relative nubmers whilst in insert mode
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number && mode() != "i" | set relativenumber   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number                  | set norelativenumber | endif
augroup END

" Set leader to a comma, becuase backslash is TOO far away
let mapleader = ","

" ============ Turn off Swap Files ============
set noswapfile
set nobackup
set nowritebackup

" ============ Indentation ============
set smartindent
set smarttab
set shiftwidth=2                  " Number of spaces to use in each autoindent step
set softtabstop=2                 " Number of spaces to skip/insert when <BS> or <tab>ing
set tabstop=2                     " <tab> uses width of two spaces
set expandtab                     " Use spaces, not tabs

" Better display for messages
set cmdheight=2

" ============ File types ============
" Let file types decide their plugin and indent settings
filetype plugin on
filetype indent on

" Allow local .vimrc overrides
set exrc

" Get our colours right
set t_Co=256
let base16colorspace=256
colorscheme base16-monokai
hi MatchParen cterm=bold
let g:airline_theme='base16'
set termguicolors " makes devicons appear in colour

" make incomplete lines and tabs visible
set listchars=tab:▸\ ,extends:>,precedes:<

" ============ Folds ============
set foldmethod=indent       " fold based on indentation
set nofoldenable            " dont fold by default

" ============ Completion ============
set wildmode=list:longest

" ============ Search =============
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital"

" ============ Status Bar  =============
" Always show the status bar
set laststatus=2
" Put git branch in the status bar
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Switch wrap off for everything
set nowrap

" Lets allow mouse scrolling, because it's the 21st centuary after all
set mouse=a

" ============ Config files  =============
let $CONFIG = "$HOME/.config/nvim/config"
lua require('init')
source $CONFIG/pluginconfig.vim
source $CONFIG/rails_test.vim
source $CONFIG/keybinds.vim

command! Xs :mks! | :xa "save the session, save modified files, and exit

" ============ Autocommands =============
if has("autocmd")
  augroup my_auto_commands
    " clear out my autocommands first, in case we have already loaded them
    autocmd!

    " Four space indent for JS, HTML and ERB
    autocmd FileType html setlocal shiftwidth=4 tabstop=4
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType typescript setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType typescriptreact setlocal ts=4 sts=4 sw=4 expandtab
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

    " mark the 80th column for git commits
    autocmd FileType gitcommit set colorcolumn=81

    " syntax highlighting for the forgotten ruby files
    autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

    "autocmd BufWritePost * nested if &filetype=='plantuml' | Make!

    " Autoformat proto files
    let g:clang_format#style_options = { "IndentWidth": 4, "ColumnLimit": 120 }
    autocmd FileType proto ClangFormatAutoEnable

    autocmd BufRead,BufNewFile */99designs/workbench/* let g:rspec_command='call VimuxRunCommand("99dev compose run workbench bundle exec rspec {spec}")'

    " wrap long lines in quickfix
    augroup quickfix
      autocmd!
      autocmd FileType qf setlocal wrap
    augroup END

    " hypens are part of a word in css 
    au! FileType css,scss setl iskeyword+=-
  augroup END
end

if has('nvim')
  " ESC out of terminal mode
  :tnoremap <Esc> <C-\><C-n>
  :tnoremap <M-[> <Esc>
endif

" ----------------------------------------------------------------------------
" DiffRev
" ----------------------------------------------------------------------------
let s:git_status_dictionary = {
            \ "A": "Added",
            \ "B": "Broken",
            \ "C": "Copied",
            \ "D": "Deleted",
            \ "M": "Modified",
            \ "R": "Renamed",
            \ "T": "Changed",
            \ "U": "Unmerged",
            \ "X": "Unknown"
            \ }
function! s:get_diff_files(rev)
  let list = map(split(system(
              \ 'git diff --name-status '.a:rev), '\n'),
              \ '{"filename":matchstr(v:val, "\\S\\+$"),"text":s:git_status_dictionary[matchstr(v:val, "^\\w")]}'
              \ )
  call setqflist(list)
  copen
endfunction

command! -nargs=1 DiffRev call s:get_diff_files(<q-args>)

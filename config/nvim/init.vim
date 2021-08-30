" ============ General Config ============
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=1000                " number of lines of command line history to store
set showcmd		                  " display incomplete commands
set showmode		                " display current mode
set autowrite                   " ensure files are written when we call :make
set autoread                    " Reload files changed outside of vim
set hidden                      " allow hidden buffers
set nofsync                     " fsync causes vim to hang when closing https://github.com/ludovicchabant/vim-gutentags/issues/167#issuecomment-564889922

" Use hybrid line numbers; relative numbering for all lines except the current
" Also turn off relative nubmers whilst in insert mode
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number && mode() != "i" | set relativenumber   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &number                  | set norelativenumber | endif
augroup END

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
  set hlsearch
endif

" Set leader to a comma, becuase backslash is TOO far away
let mapleader = ","

" ============ Plug ============
let $CONFIG = "$HOME/.config/nvim/config"
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
set background=dark
let base16colorspace=256
colorscheme base16-monokai
hi MatchParen cterm=bold
let g:airline_theme='base16'

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
" source $CONFIG/coc.vim


" ============ Autocommands =============
if has("autocmd")
  augroup my_auto_commands
    " clear out my autocommands first, in case we have already loaded them
    autocmd!

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

    " syntax highlighting for the forgotten ruby files
    autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

    "autocmd BufWritePost * nested if &filetype=='plantuml' | Make!

    " Autoformat proto files
    let g:clang_format#style_options = { "IndentWidth": 4, "ColumnLimit": 120 }
    autocmd FileType proto ClangFormatAutoEnable

    " Better Go
     "au FileType go nmap <Leader>s <Plug>(go-implements)
     "au FileType go nmap <Leader>i <Plug>(go-info)
     "au FileType go nmap <Leader>gd <Plug>(go-doc)
     "au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
     "au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
     "au FileType go nmap <leader>r <Plug>(go-run)
     "au FileType go nmap <leader>b <Plug>(go-build)
     "au FileType go nmap <leader>t <Plug>(go-test)
     "au FileType go nmap <leader>c <Plug>(go-coverage)
     "au FileType go nmap <Leader>ds <Plug>(go-def-split)
     "au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
     "au FileType go nmap <Leader>dt <Plug>(go-def-tab)

     " Enable syntax highting on everything
     "let g:go_highlight_functions = 1
     "let g:go_highlight_methods = 1
     "let g:go_highlight_structs = 1
     "let g:go_highlight_operators = 1
     "let g:go_highlight_build_constraints = 1

     " run goimports instead of gofmt on save; boom, instant imports!
     "let g:go_fmt_command = "goimports"

     " Stop vim-go and GoFmt from ruining all my folds (https://github.com/fatih/vim-go/issues/502)
     "let g:go_fmt_experimental = 1

    autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

    autocmd BufRead,BufNewFile */99designs/workbench/* let g:rspec_command='call VimuxRunCommand("99dev compose run workbench bundle exec rspec {spec}")'

    " wrap long lines in quickfix
    augroup quickfix
      autocmd!
      autocmd FileType qf setlocal wrap
    augroup END
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

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'solargraph', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

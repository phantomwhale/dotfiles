call plug#begin('~/.config/nvim/plugged')

" Plugs go here

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }


Plug 'scrooloose/vim-slumlord'
" Run tests in a separate terminal
Plug 'janko/vim-test'
Plug 'dbakker/vim-projectroot'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'rstacruz/sparkup'
Plug 'Raimondi/delimitMate'
Plug 'rizzatti/dash.vim'
Plug 'rking/ag.vim'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/RelativeNumberCurrentWindow'
Plug 'yssl/QFEnter'

Plug 'junegunn/goyo.vim'  "distraction free writing
Plug 'junegunn/limelight.vim'

" JS/TS import organiser
Plug 'ruanyl/vim-sort-imports', { 'do': 'npm install -g import-sort-cli import-sort-parser-babylon import-sort-parser-typescript import-sort-style-renke' }

call plug#end()

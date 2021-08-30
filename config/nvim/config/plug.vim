call plug#begin('~/.config/nvim/plugged')

" Plugs go here

" Markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

Plug 'scrooloose/vim-slumlord'
Plug 'dbakker/vim-projectroot'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'rstacruz/sparkup'
Plug 'vim-scripts/matchit.zip'

" JS/TS import organiser

call plug#end()

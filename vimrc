execute pathogen#infect()
syntax on
filetype plugin indent on

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

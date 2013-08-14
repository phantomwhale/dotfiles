" Window Navigation ------------------------------------------------------------
" Use ctrl+(h|j|k|j) to move through open windows.
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Leader took away our comma - remap to \
noremap \ ,

"Quick escape using 'jk' combination
imap jk <Esc>          

" Remove search highlighting
noremap <Leader>l :<C-u>nohlsearch<CR>

" Nerd Tree
noremap <Leader>n :NERDTreeToggle<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"Rspec.vim mappings
map <Leader>s :call RunCurrentSpecFile()<CR>
map <Leader>S :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>


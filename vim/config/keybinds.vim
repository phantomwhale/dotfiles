" Leader took away our comma - remap to \
noremap \ ,

" disable ex-mode mapping in normal mode. Because it's werid
nnoremap Q <nop>

" Remove search highlighting
noremap <Leader>l :<C-u>nohlsearch<CR>
noremap <Leader><space> :<C-u>nohlsearch<CR>

" Keep searches centered
noremap n nzzzv
noremap N Nzzzv

" Follow tags when using putty, which ignores Ctrl-]
noremap <Leader>] <C-]>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"Rspec.vim mappings
map <Leader>s :call RunCurrentSpecFile()<CR>
map <Leader>S :call RunNearestSpec()<CR>
map <Leader>L :call RunLastSpec()<CR>
map <Leader>A :call RunAllSpecs()<CR>

" XMP Filter keybinds
autocmd FileType ruby nmap <buffer> <F2> <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <F2> <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <F2> <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <F3> <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <F3> <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <F3> <Plug>(xmpfilter-run)

" Tag bar toggle
nmap <F8> :TagbarToggle<CR>

" Window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Remove trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Apparently, this changed @tpope's life
nnoremap <silent> <C-W>z :wincmd z<Bar>cclose<Bar>lclose<CR>

" Quick editing of config files
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e ~/.vimrc<cr>
nnoremap <leader>ep <C-w>s<C-w>j<C-w>L:e $CONFIG/plug.vim<cr>
nnoremap <leader>ek <C-w>s<C-w>j<C-w>L:e $CONFIG/keybinds.vim<cr>
nnoremap <leader>ec <C-w>s<C-w>j<C-w>L:e $CONFIG/pluginconfig.vim<cr>

" Auto-create missing rspec tests
noremap <leader>as :call rails_test#hsplit_spec()<cr>
noremap <leader>av :call rails_test#vsplit_spec()<cr>

" shortcut for updating vim modules and vim plug all at once
command! PU PlugUpdate | PlugUpgrade

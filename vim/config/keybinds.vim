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
noremap <Leader><space> :<C-u>nohlsearch<CR>

" Keep searches centered
noremap n nzzzv
noremap N Nzzzv

" Nerd Tree
noremap <Leader>n :NERDTreeToggle<CR>

" Follow tags via putty, which ignores Ctrl-]
noremap <Leader>] <C-]>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Setup mappings for ruby-debugger.
let g:ruby_debugger_no_maps = 1
nmap <leader>db <plug>ruby_debugger_breakpoint
nmap <leader>dv <plug>ruby_debugger_open_variables
nmap <leader>dm <plug>ruby_debugger_open_breakpoints
nmap <leader>dt <plug>ruby_debugger_open_frames
nmap <leader>ds <plug>ruby_debugger_step
nmap <leader>df <plug>ruby_debugger_finish
nmap <leader>dn <plug>ruby_debugger_next
nmap <leader>dc <plug>ruby_debugger_continue
nmap <leader>de <plug>ruby_debugger_exit
nmap <leader>dd <plug>ruby_debugger_remove_breakpoints

"Rspec.vim mappings
map <Leader>s :call RunCurrentSpecFile()<CR>
map <Leader>S :call RunNearestSpec()<CR>
map <Leader>L :call RunLastSpec()<CR>

" XMP Filter keybinds
map <F2> <Plug>(xmpfilter-mark)
map <F3> <Plug>(xmpfilter-run)

" Use F5 to refresh Command-T bindings
" noremap <F5> :CommandTFlush<CR>

" Tag bar toggle
nmap <F8> :TagbarToggle<CR>

" Tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabedit<Space>
nnoremap tn  :tabnext<Space>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>

" Remove trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Apparently, this changed @tpope's life
nnoremap <silent> <C-W>z :wincmd z<Bar>cclose<Bar>lclose<CR>

" Quick editing of config files
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e $MYVIMRC<cr>
nnoremap <leader>et <C-w>s<C-w>j<C-w>L:e ~/.tmux.conf<cr>
nnoremap <leader>eb <C-w>s<C-w>j<C-w>L:e $CONFIG/vundle.vim<cr>


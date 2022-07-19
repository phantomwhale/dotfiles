" Leader took away our comma - remap to \
noremap \ ,

" disable ex-mode mapping in normal mode. Because it's werid
nnoremap Q <nop>

" Remove search highlighting
noremap <Leader>l :<C-u>nohlsearch<CR>
noremap <Leader><space> :<C-u>nohlsearch<CR>

" Keep searches centered (zz) and open any folds for searches (zv)
noremap n nzzzv
noremap N Nzzzv
noremap [c [czzzv
noremap ]c ]czzzv

" Follow tags when using putty, which ignores Ctrl-]
noremap <Leader>] <C-]>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

"Rspec.vim mappings
map <Leader>s :call RunCurrentSpecFile()<CR>
map <Leader>S :call RunNearestSpec()<CR>
map <Leader>L :call RunLastSpec()<CR>
map <Leader>A :call RunAllSpecs()<CR>

" Test vim mappings
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

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
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e $CONFIG/../init.vim<cr>
nnoremap <leader>el <C-w>s<C-w>j<C-w>L:e $CONFIG/../lua/init.lua<cr>
nnoremap <leader>ep <C-w>s<C-w>j<C-w>L:e $CONFIG/../lua/plugins/init.lua<cr>
nnoremap <leader>ek <C-w>s<C-w>j<C-w>L:e $CONFIG/keybinds.vim<cr>
nnoremap <leader>ec <C-w>s<C-w>j<C-w>L:e $CONFIG/pluginconfig.vim<cr>

" Auto-create missing rspec tests
noremap <leader>as :call rails_test#hsplit_spec()<cr>
noremap <leader>av :call rails_test#vsplit_spec()<cr>

" Telescope (I swear I'll put this into Lua one day)
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>rw <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" EXPERIMENTAL
"

" https://www.reddit.com/r/vim/comments/21f4gm/best_workflow_when_using_fugitive/

nnoremap <Leader>gs :Git status<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gL :exe ':!cd ' . expand('%:p:h') . '; git lgt'<CR>
nnoremap <Leader>gl :exe ':!cd ' . expand('%:p:h') . '; git lgtt'<CR>
nnoremap <Leader>gh :Gclog<CR>
nnoremap <Leader>gH :Gclog<CR>:set nofoldenable<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>g- :Git stash<CR>:e<CR>
nnoremap <Leader>g+ :Git stash pop<CR>:e<CR>

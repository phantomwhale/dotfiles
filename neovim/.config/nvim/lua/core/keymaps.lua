vim.keymap.set("n", "Q", "<nop>")

-- Keep searches centered (zz) and open any folds for searches (zv)
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "[c", "[czzzv")
vim.keymap.set("n", "]c", "]czzzv")

-- Test vim mappings
vim.keymap.set("n", "t<C-n>", "<cmd>TestNearest<CR>", { desc = "Run nearest test to cursor", silent = true })
vim.keymap.set("n", "t<C-f>", "<cmd>TestFile<CR>", { silent = true })
vim.keymap.set("n", "t<C-s>", "<cmd>TestSuite<CR>", { silent = true })
vim.keymap.set("n", "t<C-l>", "<cmd>TestLast<CR>", { silent = true })
vim.keymap.set("n", "t<C-g>", "<cmd>TestVisit<CR>", { silent = true })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = 'Move focus to the left window' })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = 'Move focus to the lower window' })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = 'Move focus to the right window' })

-- Remove search highlighting
vim.keymap.set("n", "<leader>l", "<cmd>nohlsearch<CR>")

-- Apparently, this changed @tpope's life
vim.keymap.set("n", "<C-w>z", "<cmd>wincmd z<Bar>cclose<Bar>lclose<CR>", { silent = true })

-- Go formating
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

vim.cmd([[
" Leader took away our comma - remap to \
noremap \ ,

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Force C-l to work in Netrw
function! NetrwMappings()
	nnoremap <buffer> <C-h> :wincmd h<cr>
	nnoremap <buffer> <C-j> :wincmd j<cr>
	nnoremap <buffer> <C-k> :wincmd k<cr>
	nnoremap <buffer> <C-l> :wincmd l<cr>
endfunction

augroup netrw_mappings
  autocmd!
  autocmd filetype netrw call NetrwMappings()
augroup END
" think this does some odd output on load, but I'll keep it for now

" Follow tags when using putty, which ignores Ctrl-]
noremap <Leader>] <C-]>

" XMP Filter keybinds
autocmd FileType ruby nmap <buffer> <F2> <Plug>(xmpfilter-mark)
autocmd FileType ruby xmap <buffer> <F2> <Plug>(xmpfilter-mark)
autocmd FileType ruby imap <buffer> <F2> <Plug>(xmpfilter-mark)

autocmd FileType ruby nmap <buffer> <F3> <Plug>(xmpfilter-run)
autocmd FileType ruby xmap <buffer> <F3> <Plug>(xmpfilter-run)
autocmd FileType ruby imap <buffer> <F3> <Plug>(xmpfilter-run)

" Remove trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Quick editing of config files
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/init.lua<cr>
nnoremap <leader>el <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/lua/<cr>
nnoremap <leader>ep <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/lua/packer_init.lua<cr>
nnoremap <leader>ek <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/lua/core/keymaps.lua<cr>
nnoremap <leader>eo <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/lua/core/options.lua<cr>
nnoremap <leader>ec <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/lua/plugins/pluginconfig.lua<cr>

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
]])

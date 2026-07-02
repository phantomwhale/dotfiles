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

-- Buffer naviation
vim.keymap.set("n", "<leader>bd", ":bp | bd #<CR>", { desc = 'Go to prevoius buffer and close current one' })

-- Remove search highlighting
vim.keymap.set("n", "<leader>l", "<cmd>nohlsearch<CR>")

-- Apparently, this changed @tpope's life
vim.keymap.set("n", "<C-w>z", "<cmd>wincmd z<Bar>cclose<Bar>lclose<CR>", { silent = true })

-- Git: list changed files in the quickfix via :DiffRev (defined in init.lua)
vim.keymap.set("n", "<leader>gc", "<cmd>DiffRev HEAD~1 HEAD<CR>", { desc = "Git [c]ommit changed files (latest commit)" })

-- Resolve the repo's default branch from origin/HEAD (a purely local read), falling
-- back to the first well-known base ref that actually exists. Exact ref verification
-- avoids false matches on lookalikes such as a branch named "origin/someone/main".
local function git_default_branch()
  local head = vim.trim(vim.fn.system("git symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null"))
  if vim.v.shell_error == 0 and head ~= "" then
    return head
  end
  for _, ref in ipairs({ "origin/main", "origin/master", "main", "master" }) do
    vim.fn.system("git rev-parse --verify --quiet " .. ref .. " 2>/dev/null")
    if vim.v.shell_error == 0 then
      return ref
    end
  end
  return "main"
end

vim.keymap.set("n", "<leader>gB", function()
  vim.cmd("DiffRev " .. git_default_branch() .. "...HEAD")
end, { desc = "Git [B]ranch changed files (vs default branch)" })

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

" Remove trailing whitespace
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Quick editing of config files
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/init.lua<cr>
nnoremap <leader>el <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/lua/<cr>

nnoremap <leader>ek <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/lua/core/keymaps.lua<cr>
nnoremap <leader>eo <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/lua/core/options.lua<cr>
nnoremap <leader>ec <C-w>s<C-w>j<C-w>L:e ~/.config/nvim/lua/plugins/<cr>

" Git log commands (not fugitive)
nnoremap <Leader>gL :exe ':!cd ' . expand('%:p:h') . '; git lgt'<CR>
nnoremap <Leader>gl :exe ':!cd ' . expand('%:p:h') . '; git lgtt'<CR>
]])

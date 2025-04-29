-- don't ruby formatting on save
vim.g.rufo_auto_formatting = 0

-- Turn on golangci-lint by default
vim.g.go_metalinter_enabled = 1
vim.g.go_metalinter_autosave = 1

vim.g.ruby_debugger_create_default_mappings = 0

-- Format js and jsx files with jsx formatter
vim.g.jsx_ext_required = 0

-- Add delimit expansion options
vim.g.delimitMate_expand_cr = 1
vim.g.delimitMate_expand_space = 1

-- let ag search hidden files
vim.g.ag_prg = "ag --vimgrep --hidden"

-- unlimited file in CTRL-P
vim.g.ctrlp_max_files = 0

-- exclude git ignored files
vim.g.ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

-- Goyo
vim.g.goyo_width = 120

vim.cmd([[
match ErrorMsg '\s\+$'

function! s:goyo_enter()
  set wrap
  set linebreak
  Limelight
endfunction

function! s:goyo_leave()
  set nowrap
  set nolinebreak
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Run tests in a split terminal (default 'basic' strategy uses a new tab)
let test#strategy = "neovim"
]])

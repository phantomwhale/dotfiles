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
vim.g.ag_prg="ag --vimgrep --hidden"

-- unlimited file in CTRL-P
vim.g.ctrlp_max_files=0

-- exclude git ignored files
vim.g.ctrlp_user_command='ag -Q -l --nocolor --hidden -g "" %s'

-- Goyo
vim.g.goyo_width=120

vim.cmd( [[
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

" Run 99dev project tests inside the appropriate docker container
" Note that this assumes the docker container is named after the project root
" folder, which is USUALLY the rule...
function! NNdevTransform(cmd) abort
  let docker_project = fnamemodify(FindRootDirectory(), ':t')
  return '99dev compose run --no-deps --rm '.docker_project.' '.a:cmd
endfunction
let g:test#custom_transformations = {'99dev': function('NNdevTransform')}

if !empty(glob("99dev.yml"))
  let g:test#transformation = '99dev'
endif

let g:rails_projections = {
    \    "app/controllers/*_controller.rb": {
    \      "alternate": [
    \          "spec/requests/{}_spec.rb",
    \          "spec/requests/{}_request_spec.rb",
    \          "spec/requests/{}_controller_spec.rb",
    \          "spec/controllers/{}_controller_spec.rb",
    \      ],
    \    },
    \    "spec/requests/*_request_spec.rb": {
    \      "alternate": [
    \          "app/controllers/{}_controller.rb",
    \      ]
    \    },
    \    "spec/requests/*_spec.rb": {
    \      "alternate": [
    \          "app/controllers/{}.rb",
    \          "app/controllers/{}_controller.rb",
    \      ]
    \    },
    \    "spec/routing/*_routing_spec.rb": {
    \      "alternate": [
    \          "app/controllers/{}_controller.rb",
    \      ]
    \    },
    \    "spec/routing/*_spec.rb": {
    \      "alternate": [
    \          "app/controllers/{}.rb",
    \          "app/controllers/{}_controller.rb",
    \      ]
    \    },
    \ }

]] )

match ErrorMsg '\s\+$'

" Disable endwise key mapping as it conflicts with <CR> mapping we use for
let g:endwise_no_mappings = 1

" run ruby formatting on save
" EDIT or actually don't, as it tends to add extra changes to otherwise
" simple commits, that cause messy PRs
let g:rufo_auto_formatting = 0

" Turn on golangci-lint by default
let g:go_metalinter_enabled = 1
let g:go_metalinter_autosave = 1

let g:ruby_debugger_create_default_mappings = 0

" Format js and jsx files with jsx formatter
let g:jsx_ext_required = 0

" Add delimit expansion options
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" let ag search hidden files
let g:ag_prg="ag --vimgrep --hidden"

" unlimited file in CTRL-P
let g:ctrlp_max_files=0

" exclude git ignored files
let g:ctrlp_user_command='ag -Q -l --nocolor --hidden -g "" %s'

" Run tests in a split terminal (default 'basic' strategy uses a new tab)
let test#strategy = "neovim"

" Run 99dev project tests inside the appropriate docker container
" Note that this assumes the docker container is named after the project root
" folder, which is USUALLY the rule...
function! NNdevTransform(cmd) abort
  let docker_project = fnamemodify(projectroot#guess(), ':t')
  return '99dev compose run --no-deps '.docker_project.' '.a:cmd
endfunction
let g:test#custom_transformations = {'99dev': function('NNdevTransform')}

if !empty(glob("99dev.yml"))
  let g:test#transformation = '99dev'
endif

" Goyo
let g:goyo_width=120

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

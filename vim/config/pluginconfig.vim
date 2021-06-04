match ErrorMsg '\s\+$'

" Disable endwise key mapping as it conflicts with <CR> mapping we use for
let g:endwise_no_mappings = 1

" Configure ALE to use fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'typescript': ['tslint', 'prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'css': ['prettier'],
\}
let g:ale_fix_on_save = 1

" run ruby formatting on save
" EDIT or actually don't, as it tends to add extra changes to otherwise
" simple commits, that cause messy PRs
let g:rufo_auto_formatting = 0

" CoC extensions
" These can be installed with :CocInstall, but I want a record of them here
let g:coc_global_extensions = [
\  'coc-tsserver',
\  'coc-solargraph',
\  'coc-omnisharp'
\]

" Turn off goto definition from vim-go - we'll use CoC instead
let g:go_def_mapping_enabled = 0

let g:ruby_debugger_create_default_mappings = 0

" Format js and jsx files with jsx formatter
let g:jsx_ext_required = 0

" Add delimit expansion options
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" leave c-n alone, sparkup !
let g:sparkupNextMapping = '<C-F>'

" ultisnips gives up tab to YCM, so we'll take a different key
let g:UltiSnipsExpandTrigger='<C-J>'

" Allow sparkup completion in JS(X) files
autocmd FileType javascript.jsx runtime! ftplugin/html/sparkup.vim
autocmd FileType javascript.js runtime! ftplugin/html/sparkup.vim

" let ag search hidden files
let g:ag_prg="ag --vimgrep --hidden"

" unlimited file in CTRL-P
let g:ctrlp_max_files=0

" exclude git ignored files
let g:ctrlp_user_command='ag -Q -l --nocolor --hidden -g "" %s'

" Stop gutentags getting upset in short-lived sessions
" https://github.com/ludovicchabant/vim-gutentags/issues/178
let g:gutentags_exclude_filetypes=['gitcommit']

" Run tests in a split terminal (default 'basic' strategy uses a new tab)
let test#strategy = "neovim"

" Run 99dev project tests inside the appropriate docker container
" Note that this assumes the docker container is named after the project root
" folder, which is USUALLY the rule...
function! NNdevTransform(cmd) abort
  let docker_project = fnamemodify(projectroot#guess(), ':t')
  return '99dev compose run '.docker_project.' '.a:cmd
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

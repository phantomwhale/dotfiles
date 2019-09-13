match ErrorMsg '\s\+$'

" rubocop and ruby-lint in syntastic linter
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_ruby_rubocop_exe = 'bundle exec rubocop'
let g:syntastic_aggregate_errors = 1

" ESlint for javascript checking - supports React / JSX / ES6
let g:syntastic_javascript_checkers = ['eslint']

" Configure ALE to use fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'typescript': ['tslint', 'prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'css': ['prettier'],
\}
let g:ale_fix_on_save = 1

" CoC extensions
" These can be installed with :CocInstall, but I want a record of them here
let g:coc_global_extensions = [
\  'coc-tsserver',
\  'coc-solargraph'
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

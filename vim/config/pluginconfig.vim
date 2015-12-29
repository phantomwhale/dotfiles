" we'll need an interactive shell if we want to execute our custom bash script command
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

match ErrorMsg '\s\+$'

" rubocop and ruby-lint in syntastic linter
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_aggregate_errors = 1

" ESlint for javascript checking - supports React / JSX / ES6
let g:syntastic_javascript_checkers = ['eslint']

let g:ruby_debugger_create_default_mappings = 0

" Format js and jsx files with jsx formatter
let g:jsx_ext_required = 0

" Add delimit expansion options
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" unlimited file in CTRL-P
let g:ctrlp_max_files=0

" exclude git ignored files
let g:ctrlp_user_command = {
  \ 'types': {
    \ 1: ['.git', 'git --git-dir=%s/.git ls-files --exclude-standard -oc | egrep -v "\.(png|jpg|jpeg|gif)$|node_modules"'],
    \ },
  \ 'fallback': 'find %s -type f'
  \ }


" we'll need an interactive shell if we want to execute our custom bash script command
let g:rspec_command = "Dispatch bundle exec rspec {spec}"

match ErrorMsg '\s\+$'

" rubocop and ruby-lint in syntastic linter
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_aggregate_errors = 1

let g:ruby_debugger_create_default_mappings = 0

" unlimited file in CTRL-P
let g:ctrlp_max_files=0

"let NERDTreeHijackNetrw=1

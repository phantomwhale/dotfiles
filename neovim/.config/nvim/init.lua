vim.g.mapleader = ","   -- map ',' to leader; set this first to ensure other mappings use it

_G.global = {}
require('packer_init')
require('plugins/pluginconfig')
require('lsp')
require('core/options')
require('core/keybinds')
require('core/rails_test') -- TODO: is this still needed? Currently broken

-- terminal remaps
vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]], {})
vim.keymap.set('t', '<M-[>', '<ESC>', {})

-- things that are staying as vimscript:
vim.cmd( [[
colorscheme base16-monokai


"                        _____________________________________________________
"                        |                                                     |
"               _______  |                                                     |
"              / _____ | |                       MOVING TO LUA                 |
"             / /(__) || |                                                     |
"    ________/ / |OO| || |                                                     |
"   |         |-------|| |                                                     |
"  (|         |     -.|| |_______________________                              |
"   |  ____   \       ||_________||____________  |             ____      ____  |
"  /| / __ \   |______||     / __ \   / __ \   | |            / __ \    / __ \ |\
"  \|| /  \ |_______________| /  \ |_| /  \ |__| |___________| /  \ |__| /  \|_|/
"     | () |                 | () |   | () |                  | () |    | () |
"      \__/                   \__/     \__/                    \__/      \__/
"
" Moving this file into lua/init.lua until it can take over as the main init file

if has("autocmd")
  augroup my_auto_commands
    " clear out my autocommands first, in case we have already loaded them
    autocmd!

    " Four space indent for JS, HTML and ERB
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType typescript setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType typescriptreact setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType eruby setlocal ts=4 sts=4 sw=4 expandtab

    " Trailing whitespace
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()

    " spellcheck on markdown and git commits
    autocmd BufRead,BufNewFile *.md setlocal spell
    autocmd FileType gitcommit setlocal spell

    " mark the 80th column for git commits
    autocmd FileType gitcommit set colorcolumn=81

    " syntax highlighting for the forgotten ruby files
    autocmd BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

    "autocmd BufWritePost * nested if &filetype=='plantuml' | Make!

    " wrap long lines in quickfix
    augroup quickfix
      autocmd!
      autocmd FileType qf setlocal wrap
    augroup END

    " hypens are part of a word in css 
    au! FileType css,scss setl iskeyword+=-
  augroup END
end

" ----------------------------------------------------------------------------
" DiffRev
" ----------------------------------------------------------------------------
let s:git_status_dictionary = {
            \ "A": "Added",
            \ "B": "Broken",
            \ "C": "Copied",
            \ "D": "Deleted",
            \ "M": "Modified",
            \ "R": "Renamed",
            \ "T": "Changed",
            \ "U": "Unmerged",
            \ "X": "Unknown"
            \ }
function! s:get_diff_files(rev)
  let list = map(split(system(
              \ 'git diff --name-status '.a:rev), '\n'),
              \ '{"filename":matchstr(v:val, "\\S\\+$"),"text":s:git_status_dictionary[matchstr(v:val, "^\\w")]}'
              \ )
  call setqflist(list)
  copen
endfunction

command! -nargs=1 DiffRev call s:get_diff_files(<q-args>)
]] )

-- Built-in vim-ruby indent (GetRubyIndent) locates strings/comments via synID(),
-- which needs legacy syntax/ruby.vim groups (rubyString, rubyComment, ...). This
-- config highlights with tree-sitter and never loads legacy syntax, so those
-- groups are undefined: hlID('ruby...') returns 0, colliding with synID()==0 and
-- making every keyword look string-quoted. Block detection then fails and `=`
-- becomes a no-op. Loading legacy syntax restores synID() so `=` indents again.
vim.bo.syntax = "ruby"

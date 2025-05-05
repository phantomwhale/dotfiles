return {
  cmd = { "rubocop", "--lsp", "--ignore-unrecognized-cops", "--config", vim.fn.expand('$HOME/.rubocop.yml') },
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" }
}

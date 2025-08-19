return {
  cmd = { 'vale-ls' },
  filetypes = { "markdown", "text", "tex", "rst" },
  root_markers = { "vale/.vale.ini" },
  init_options = {
    configPath = vim.fn.getcwd() .. "/vale/.vale.ini"
  }
}

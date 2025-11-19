local lsp_utils = require("modules.lsp-utils")
local rubocop_exec = lsp_utils.check_executable({
  -- { cmd = { "bundle", "exec", "rubocop", "--lsp" },     check = "bundle exec rubocop --version" },
  -- { cmd = { "mise", "exec", "--", "rubocop", "--lsp" }, check = "mise exec -- rubocop --version" },
  { cmd = { "rubocop", "--lsp" }, check = "rubocop --version" },
})

table.insert(rubocop_exec, "--ignore-unrecognized-cops")
table.insert(rubocop_exec, "--config")
table.insert(rubocop_exec, vim.fn.expand('$HOME/.rubocop.yml'))

RD = RD or {}

function RD.join(tbl, sep)
  local ret = ''
  for i, v in pairs(tbl) do
    ret = ret .. i .. sep
  end
  return ret:sub(1, - #sep - 1)
end

function RD.map(tbl, f)
  local t = {}
  for k, v in pairs(tbl) do
    t[f(v)] = true
  end
  return t
end

function RD.rubocop_disable()
  local current_lnum = vim.api.nvim_win_get_cursor(0)[1]
  local current_line = vim.api.nvim_get_current_line()

  local diagnostics = vim.diagnostic.get(0, { lnum = current_lnum - 1 })
  local diagnostic = diagnostics[1]

  if diagnostic and diagnostic.source == 'RuboCop' then
    local code = RD.join(RD.map(diagnostics, function(d) return d.code end), ', ')

    if diagnostic.lnum == diagnostic.end_lnum then
      local new_text = current_line .. ' # rubocop:disable ' .. code
      vim.api.nvim_set_current_line(new_text)
    else
      local indent = tonumber(vim.call('indent', current_lnum))
      local padding = string.rep(' ', indent)

      local enable_text = padding .. '# rubocop:enable ' .. code
      vim.api.nvim_buf_set_lines(0, diagnostic.end_lnum + 1, diagnostic.end_lnum + 1, false, { enable_text })

      local disable_text = padding .. '# rubocop:disable ' .. code
      vim.api.nvim_buf_set_lines(0, diagnostic.lnum, diagnostic.lnum, false, { disable_text })
    end
  end
end

vim.api.nvim_set_keymap('n', '<leader>rd', '<cmd>lua RD.rubocop_disable()<CR>', {})

return {
  cmd = rubocop_exec,
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" }
}

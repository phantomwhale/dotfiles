local lsp_utils = require("modules.lsp-utils")

local RD = {}

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

vim.keymap.set('n', '<leader>rd', function() RD.rubocop_disable() end, {})

return {
  -- A project with its own `.rubocop.yml` (or a gitignored
  -- `.rubocop_personal.yml` overlay) uses the project's bundled rubocop;
  -- otherwise the global rubocop is pointed at ~/.rubocop.yml. The no-config
  -- branch must avoid `bundle exec`: it errors without a Gemfile and lacks the
  -- global plugin gems ~/.rubocop.yml needs, so the config would fail to load.
  cmd = function(dispatchers, config)
    local root = config.root_dir or vim.fn.getcwd()

    local has_project_config = vim.fn.filereadable(vim.fs.joinpath(root, '.rubocop.yml')) == 1
    local personal = vim.fs.joinpath(root, '.rubocop_personal.yml')
    local has_personal = vim.fn.filereadable(personal) == 1

    local rubocop_exec
    if has_project_config or has_personal then
      rubocop_exec = lsp_utils.check_executable({
        { cmd = { "mise", "x", "--", "bundle", "exec", "rubocop", "--lsp" } },
        { cmd = { "bundle", "exec", "rubocop", "--lsp" } },
        { cmd = { "rubocop", "--lsp" } },
      })
    else
      rubocop_exec = lsp_utils.check_executable({
        { cmd = { "rubocop", "--lsp" } },
        { cmd = { "mise", "x", "--", "rubocop", "--lsp" } },
      })

      local global = vim.fn.expand('~/.rubocop.yml')
      if vim.fn.filereadable(global) == 1 then
        table.insert(rubocop_exec, '--config')
        table.insert(rubocop_exec, global)
      end
    end

    table.insert(rubocop_exec, "--ignore-unrecognized-cops")

    if has_personal then
      table.insert(rubocop_exec, '--config')
      table.insert(rubocop_exec, personal)
    end

    return vim.lsp.rpc.start(rubocop_exec, dispatchers, { cwd = root })
  end,
  filetypes = { "ruby" },
  root_markers = { "Gemfile", ".git" }
}

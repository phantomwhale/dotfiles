local function open_current_window()
  local MiniFiles = require('mini.files')
  local file_dir = vim.api.nvim_buf_get_name(0)
  -- oil adds an "oil://" prefix to the dir name
  -- if this is an oil directory, use it's API to get the directory name
  if package.loaded.oil then
    local oil = require('oil')
    local ok, dir = pcall(oil.get_current_dir)
    if ok and dir and dir ~= '' then
      file_dir = vim.fn.fnamemodify(dir, ':p:h')
    end
  end
  MiniFiles.open(file_dir, false)
  MiniFiles.reveal_cwd()
end

return {
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    require('mini.ai').setup()
    require('mini.bracketed').setup()
    require('mini.diff').setup()
    require('mini.files').setup()
    require('mini.operators').setup()
    require('mini.pairs').setup()
    require('mini.splitjoin').setup()
    require('mini.surround').setup()
  end,
  keys = {
    { "<leader>o", open_current_window, desc = '[O]pen current window' }
  }
}

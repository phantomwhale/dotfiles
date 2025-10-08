return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    ignore = function(buf)
      -- represents the full path to the buffer
      local path = vim.api.nvim_buf_get_name(buf)
      -- returns true if path is inside obsidian vault
      return string.find(path, "Obsidian") ~= nil
    end,
  }
}

require("oil").setup({
  view_options = {
    -- Show files and directories that start with "." by default
    show_hidden = true,
    is_always_hidden = function(name, _)
      return name == ".." or name == ".git"
    end,
  }
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

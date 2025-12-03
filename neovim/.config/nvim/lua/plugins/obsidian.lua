return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/GoogleDrive/Obsidian/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/GoogleDrive/Obsidian/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>so", ":ObsidianSearch<CR>", desc = "Search obsidian files" },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/GoogleDrive/Obsidian",
      },
    },
  },
}

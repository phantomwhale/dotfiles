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
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/GoogleDrive/Obsidian",
      },
    },
  },
}

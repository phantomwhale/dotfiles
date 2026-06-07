return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/GoogleDrive/Obsidian/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/GoogleDrive/Obsidian/*.md",
  },
  keys = {
    { "<leader>so", ":Obsidian search<CR>", desc = "Search obsidian files" },
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "personal",
        path = "~/GoogleDrive/Obsidian",
      },
    },
    picker = {
      name = "snacks.picker",
    },
  },
}

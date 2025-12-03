return {
  'tpope/vim-fugitive',
  cmd = { "Git", "G", "Gdiff", "Gvdiffsplit", "Gclog", "Gread", "Gwrite" },
  keys = {
    { "<leader>gs", "<cmd>Git status<cr>", desc = "Git status" },
    { "<leader>gd", "<cmd>Gdiff<cr>", desc = "Git diff" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
    { "<leader>gh", "<cmd>Gclog<cr>", desc = "Git history" },
    { "<leader>gH", "<cmd>Gclog<cr><cmd>set nofoldenable<cr>", desc = "Git history (no folds)" },
    { "<leader>gR", "<cmd>Gread<cr>", desc = "Git read (checkout file)" },
    { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Git write (stage file)" },
    { "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
    { "<leader>g-", "<cmd>Git stash<cr><cmd>e<cr>", desc = "Git stash" },
    { "<leader>g+", "<cmd>Git stash pop<cr><cmd>e<cr>", desc = "Git stash pop" },
  },
  dependencies = {
    'tpope/vim-rhubarb', -- GitHub integration
  },
}

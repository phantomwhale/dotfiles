return {
  -- current set up for rspec only
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec"
  }
}

return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    -- snacks.nvim is configured centrally in plugins/snacks.lua;
    -- opencode requires its `input`, `picker`, and `terminal` modules.
    "folke/snacks.nvim",
  },
  keys = {
    { "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" },             desc = "Ask opencode" },
    { "<leader>ox", function() require("opencode").select() end,                          mode = { "n", "x" },             desc = "Execute opencode action" },
    { "<C-.>",      function() require("opencode").toggle() end,                          mode = { "n", "t" },             desc = "Toggle opencode" },
    { "<S-C-u>",    function() require("opencode").command("session.half.page.up") end,   desc = "opencode half page up" },
    { "<S-C-d>",    function() require("opencode").command("session.half.page.down") end, desc = "opencode half page down" },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = {
        cmd = "--copy-env opencode --port",
        enabled = "kitty",
        kitty = {
        }
      }
    }

    -- Required for `opts.events.reload`.
    vim.o.autoread = true
  end,
}

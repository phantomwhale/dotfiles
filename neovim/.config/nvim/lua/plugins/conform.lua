return {
  "stevearc/conform.nvim",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      php = { "php-cs-fixer" },
    },
    formatters = {
      ["php-cs-fixer"] = {
        command = " php-cs-fixer",
        args = {
          "fix",
          "--rules=@PSR12", -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
          "$FILENAME",
        },
        env = {
          PHP_CS_FIXER_IGNORE_ENV = "1"
        },
        stdin = false,
      },
    },
    notify_on_error = true,
  },
}

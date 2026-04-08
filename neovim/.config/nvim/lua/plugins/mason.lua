return {
  {
    'mason-org/mason.nvim',
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {},
  },

  {
    'mason-org/mason-lspconfig.nvim',
    cmd = { "LspInstall", "LspUninstall" },
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
      automatic_enable = false,
      ensure_installed = {
        "cssls",
        "html",
        "gopls",
        "graphql",
        "lua_ls",
        "phpactor",
        "rubocop",
        "ruby_lsp",
        "tailwindcss",
        "terraformls",
        "tflint",
        "ts_ls",
        "vale_ls",
      }
    }
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
      ensure_installed = {
        "erb-formatter",
        "markdownlint",
        "vale",
        "write-good",
      }
    }
  }
}

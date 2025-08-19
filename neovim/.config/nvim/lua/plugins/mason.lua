-- Mason - Manage third-party packages
return {
  {
    'mason-org/mason.nvim',
    opts = {},
  },

  -- Still need too install the LSP servers
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
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

  -- Installs non-LSP tools
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'mason-org/mason.nvim',
    },
    opts = {
      ensure_installed = {
        "erb-formatter",
        "erb-lint",
        "eslint_d",
        "markdownlint",
        "vale",
        "write-good",
      }
    }
  }
}

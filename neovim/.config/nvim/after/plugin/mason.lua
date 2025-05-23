local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end
local status3, toolinstaller = pcall(require, "mason-tool-installer")
if (not status3) then return end

mason.setup({})

lspconfig.setup {
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
  }
}

toolinstaller.setup {
  ensure_installed = {
    "erb-formatter",
    "erb-lint",
    "eslint_d",
    "markdownlint",
    "write-good",
  }
}

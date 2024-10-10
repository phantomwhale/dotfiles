local status, mason = pcall(require, "mason")
if (not status) then return end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end
local status3, toolinstaller = pcall(require, "mason-tool-installer")
if (not status3) then return end

mason.setup({})

lspconfig.setup {
  ensure_installed = {
    "ts_ls",
    "html",
    "cssls",
    "tailwindcss",
    "lua_ls",
    "graphql",
    "ruby_lsp",
    "solargraph",
    "terraformls",
    "tflint"
  }
}

toolinstaller.setup {
  ensure_installed = {
    "erb-formatter",
    "erb-lint",
    "eslint_d",
    "markdownlint",
    "write-good",
    "prettier"
  }
}

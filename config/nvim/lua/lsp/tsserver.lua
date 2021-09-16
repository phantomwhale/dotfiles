-- TS setup; copied from https://github.com/jose-elias-alvarez/dotfiles/blob/main/.config/nvim/lua/lsp/tsserver.lua
local lspconfig = require("lspconfig")

local ts_utils_settings = {
    debug = true,
    enable_import_on_completion = true,
    eslint_enable_diagnostics = true,
}

local M = {}
M.setup = function(on_attach)
    lspconfig.tsserver.setup({
        on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false

            on_attach(client, bufnr)

            local ts_utils = require("nvim-lsp-ts-utils")
            ts_utils.setup(ts_utils_settings)
            ts_utils.setup_client(client)

            local opts = { noremap=true, silent=true }
            buf_set_keymap("n", "gs", ":TSLspOrganize<CR>", opts)
            buf_set_keymap("n", "gI", ":TSLspRenameFile<CR>", opts)
            buf_set_keymap("n", "go", ":TSLspImportAll<CR>", opts)
            buf_set_keymap("n", "qq", ":TSLspFixCurrent<CR>", opts)
        end,
        flags = {
            debounce_text_changes = 150,
        }
    })
end

return M

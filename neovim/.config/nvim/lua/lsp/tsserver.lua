local typescript = require("typescript")

local M = {}
M.setup = function(on_attach)
    typescript.setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false, -- enable debug logging for commands
            go_to_source_definition = {
                fallback = true, -- fall back to standard LSP definition on failure
            },
            server = { -- pass options to lspconfig's setup method
                on_attach = function(client, bufnr)
                    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

                    client.server_capabilities.documentFormattingProvider = false
                    client.server_capabilities.documentRangeFormattingProvider = false

                    on_attach(client, bufnr)

                    --local ts_utils = require("nvim-lsp-ts-utils")
                    --ts_utils.setup(ts_utils_settings)
                    --ts_utils.setup_client(client)

                    local opts = { noremap=true, silent=true }
                    buf_set_keymap("n", "gs", ":TSLspOrganize<CR>", opts)
                    buf_set_keymap("n", "gI", ":TSLspRenameFile<CR>", opts)
                    buf_set_keymap("n", "go", ":TypescriptAddMissingImports<CR>", opts)
                    buf_set_keymap("n", "qq", ":TSLspFixCurrent<CR>", opts)
                end,
                flags = {
                    debounce_text_changes = 150,
                },
            }
        })
end

return M

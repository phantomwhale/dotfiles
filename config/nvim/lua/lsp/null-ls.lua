local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
    b.formatting.prettier.with({
        prefer_local = 'node_modules/.bin',
    }),
    b.formatting.trim_whitespace.with({ filetypes = { "tmux", "teal", "zsh" } }),
    b.formatting.shfmt,
    b.diagnostics.write_good,
    b.diagnostics.markdownlint.with({ args = { "--fix", "$FILENAME", "--config", os.getenv("HOME") .. "/.markdownlint.jsonc" } }),
    b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
    b.code_actions.gitsigns,
}

local M = {}
M.setup = function(on_attach)
    null_ls.config({
        -- debug = true,
        sources = sources,
    })
    require("lspconfig")["null-ls"].setup({
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 5000,
        }
    })
end

return M

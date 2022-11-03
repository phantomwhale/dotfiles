local null_ls = require("null-ls")
local b = null_ls.builtins

local sources = {
    b.code_actions.gitsigns,
    b.diagnostics.erb_lint,
    b.diagnostics.eslint_d,
    b.diagnostics.write_good,
    b.diagnostics.markdownlint.with({ args = { "--stdin", "--config", os.getenv("HOME") .. "/.markdownlint.jsonc" } }),
    b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
    b.formatting.prettier.with({
        prefer_local = 'node_modules/.bin',
        disabled_filetypes = { "yaml" },
    }),
    b.formatting.trim_whitespace.with({ filetypes = { "tmux", "teal", "zsh" } }),
    b.formatting.shfmt.with({
        extra_args = { "-i", "4", "-ci" },
    }),
}

local M = {}
M.setup = function(on_attach)
    null_ls.setup({
        sources = sources,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 5000,
        }
    })
end

return M

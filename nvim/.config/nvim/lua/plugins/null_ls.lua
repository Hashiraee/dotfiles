local Plugin = { "jose-elias-alvarez/null-ls.nvim" }

-- Plugin.event = "BufReadPre"

function Plugin.config()
    local null_ls = require("null-ls")

    -- Formatting
    local formatting = null_ls.builtins.formatting

    -- Diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
        debug = false,
        sources = {
            formatting.black.with { extra_args = { "--fast" } },
            formatting.isort,
            diagnostics.flake8,
        },
    })
end

return Plugin

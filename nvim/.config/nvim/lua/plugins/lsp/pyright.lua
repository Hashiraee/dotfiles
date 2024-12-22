local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
                typeCheckingMode = "off",

                -- Handle imports
                autoImportCompletions = true,

                -- Extra paths for module resolution
                extraPaths = {},

                -- Ignore specific files/directories
                ignore = {
                    "**/__pycache__",
                },
            },
        },
    },

    -- Control which files trigger pyright
    filetypes = { "python" },

    -- Additional flags for pyright
    flags = {
        debounce_text_changes = 150,
    },
})

local lspconfig = require("lspconfig")

lspconfig.basedpyright.setup({
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "off",
                autoImportCompletions = true,
                reportMissingImports = true,
                reportMissingTypeStubs = true,
            }
        }
    }
})


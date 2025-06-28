-- Install with: brew install basedpyright

---@type vim.lsp.Config
return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    settings = {
        basedpyright = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "off",
                autoImportCompletions = true,
                reportMissingImports = true,
                reportMissingTypeStubs = false,
            }
        }
    }
}

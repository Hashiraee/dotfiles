-- Install with: brew install terraform-ls

---@type vim.lsp.Config
return {
    cmd = { "terraform-ls", "serve" },
    root_markers = { '.terraform', '.git/' },
    init_options = {
        ignoreSingleFileWarning = true,
    },
    settings = {
        terraform = {
            experimentalFeatures = {
                validateOnSave = true,
            },
            format = {
                enable = true,
                formatOnSave = true,
            },
        },
    },
}

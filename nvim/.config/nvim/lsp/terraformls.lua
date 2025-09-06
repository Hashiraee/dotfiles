-- Install with: brew install terraform-ls

---@type vim.lsp.Config
return {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "tf", "tfvars", "terraform-vars" },
    root_markers = { '.git/', '.terraform' },
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

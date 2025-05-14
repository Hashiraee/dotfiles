-- Install with: brew install terraform-ls

---@type vim.lsp.Config
return {
    cmd = { "terraform-ls", "serve" },
    filetypes = { "terraform", "tf", "tfvars", "terraform-vars" },
    root_markers = { '.git/', '.terraform' },
    settings = {
        terraform = {
            -- Enable terraform.workspace support
            experimentalFeatures = {
                validateOnSave = true,
            },
            -- Format on save
            format = {
                enable = true,
                formatOnSave = true,
            },
        },
    },
}

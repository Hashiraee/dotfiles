-- Install with go

---@type vim.lsp.Config
return {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod' },
    root_markers = {'go.mod', '.git' },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
        },
    },
}

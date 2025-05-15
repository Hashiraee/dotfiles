return {
    cmd = {
        "dotnet",
        "--roll-forward-on-no-candidate-fx",
        "2",
        vim.fs.normalize("~/.local/bin/bicep-langserver/Bicep.LangServer.dll")
    },
    filetypes = { 'bicep' },
    root_markers = { 'main.bicep', '.git' },
    settings = {
        bicep = {
            diagnostics = {
                enable = true,
            },
            formatting = {
                enable = true,
            },
            hover = {
                enable = true,
            },
            completions = {
                enable = true,
            },
            validation = {
                enable = true,
            },
            trace = {
                server = "off",
            }
        }
    },
    init_options = {
        enableSnippets = true
    }
}

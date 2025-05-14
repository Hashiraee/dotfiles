vim.filetype.add({
    extension = {
        bicep = "bicep",
    },
    pattern = {
        -- Detect bicep files
        [".*%.bicep$"] = "bicep",
    }
})

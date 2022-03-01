return {
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },

            cargo = {
                loadOutDirsFromCheck = true,
            },

            procMacro = {
                enable = true,
            },
        },
    },
}

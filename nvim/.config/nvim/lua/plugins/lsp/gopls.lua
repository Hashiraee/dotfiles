local lspconfig = require("lspconfig")

lspconfig.gopls.setup({
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
        },
    },
})
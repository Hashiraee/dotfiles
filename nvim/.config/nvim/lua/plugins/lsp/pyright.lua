local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                typeCheckingMode = "off",
            },
        }
    }
})

local lspconfig = require('lspconfig')

lspconfig.r_language_server.setup({
    settings = {
        r = {
            format = {
                timeout_ms = 5000,
            },
        },
    }
})

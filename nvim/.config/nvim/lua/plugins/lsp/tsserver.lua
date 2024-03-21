local lspconfig = require("lspconfig")

lspconfig.tsserver.setup({
    settings = {
        tsserver = {
            filetypes = {
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx"
            },
        }
    }
})

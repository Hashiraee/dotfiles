local lspconfig = require("lspconfig")

lspconfig.ts_ls.setup({
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

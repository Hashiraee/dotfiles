local lspconfig = require("lspconfig")

lspconfig.terraformls.setup({
    filetypes = { "terraform", "tf", "terraform-vars" },
    cmd = { "terraform-ls", "serve" },
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
        }
    }
})

-- Automatically format .tf and .tfvars files on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.tf", "*.tfvars" },
    callback = function()
        vim.lsp.buf.format()
    end,
})

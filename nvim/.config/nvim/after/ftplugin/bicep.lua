-- Buffer-local settings for Bicep files
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2
vim.opt_local.expandtab = true
vim.opt_local.commentstring = '// %s'

-- Add buffer-local keymaps
vim.keymap.set('n', '<leader>bb', function()
    vim.cmd('!az bicep build --file ' .. vim.fn.expand('%'))
end, { buffer = true, silent = true })

-- Enable format on save for Bicep files
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = { "*.bicep", "*.bicepparam" },
    callback = function()
        vim.lsp.buf.format()
    end,
})

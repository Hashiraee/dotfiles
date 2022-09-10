local highlight_group = vim.api.nvim_create_augroup("highlight_group", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 }) end,
    group = highlight_group,
})

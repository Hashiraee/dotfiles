local present, gitsigns = pcall(require, "gitsigns")
if not present then
    return
end

gitsigns.setup {
    on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr })
    end
}

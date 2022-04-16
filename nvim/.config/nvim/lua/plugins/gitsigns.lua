local present, gitsigns = pcall(require, "gitsigns")
if not present then
    return
end

gitsigns.setup {
    signs = {
        add = {hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr"},
        change = {hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr"},
        delete = {hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr"},
        topdelete = {hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr"},
        changedelete = {hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr"}
    },

    on_attach = function(bufnr)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = bufnr })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = bufnr })
    end
}

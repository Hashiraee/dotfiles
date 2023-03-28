local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- Close certain filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf", "help", "man", "lspinfo" },
    group = group,
    command = "nnoremap <buffer> q <cmd>quit<cr>"
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Map :W to :w
vim.api.nvim_create_user_command("W", ":w", {})

-- Map :Q to :q
vim.api.nvim_create_user_command("Q", ":q", {})

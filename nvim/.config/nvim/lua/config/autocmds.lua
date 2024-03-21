local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = group,
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

-- Close certain filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "qf", "help", "man", "lspinfo", "nofile" },
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

-- Spell setting
vim.api.nvim_create_autocmd({"FileType", "BufEnter"}, {
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "tex" then
            vim.wo.spell = true
        else
            vim.wo.spell = false
        end
    end
})

-- Quickfix list delete keymap
local function remove_qf_item()
    local idx = vim.fn.line(".")
    local qf_list = vim.fn.getqflist()

    -- Return if there are no items to remove
    if #qf_list == 0 then return end

    -- Remove the item from the quickfix list
    table.remove(qf_list, idx)
    vim.fn.setqflist(qf_list, "r")

    -- Reopen quickfix window to refresh the list
    vim.cmd("copen")

    -- If not at the end of the list, stay at the same index, otherwise, go one up.
    local new_idx = idx < #qf_list and idx or math.max(idx - 1, 1)

    -- Set the cursor position directly in the quickfix window
    local winid = vim.fn.win_getid() -- Get the window ID of the quickfix window
    vim.api.nvim_win_set_cursor(winid, { new_idx, 0 })
end

vim.api.nvim_create_augroup("qf_cmds", { clear = true })
vim.api.nvim_create_user_command("RemoveQuickFixItem", remove_qf_item, {})
vim.api.nvim_create_autocmd("FileType", {
    group = "qf_cmds",
    pattern = "qf",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "dd", ":RemoveQuickFixItem<CR>", { noremap = true, silent = true })
    end,
})

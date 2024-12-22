-- Autocommands
local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = group,
    callback = function()
        vim.hl.on_yank({ higroup = "IncSearch", timeout = 100 })
    end,
})

-- Terminal options
vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Terminal options",
    group = group,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.cmd("startinsert")
    end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = group,
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Close certain filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "qf", "help", "man", "lspinfo", "nofile", "netrw", "gitsigns-blame" },
    command = "nnoremap <buffer> q <CMD>quit<CR>"
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

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
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

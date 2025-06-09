-- Options Table
local opts = { noremap = true, silent = true }

-- Disable useless binding
vim.keymap.set({ "n", "v" }, "Q", "<Nop>", opts)

-- Unbind Space (Leader)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", opts)

-- Use ESC to turn off search highlighting
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>", opts)

-- Remap window actions
vim.keymap.set({ "n", "v" }, "<Leader>w", "<C-w>", opts)

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = false })

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>Y", '"+y$', { noremap = true, silent = false })

-- Delete to system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>d", '"+d', { noremap = true, silent = false })

-- Put from system clipboard below
vim.keymap.set({ "n", "v" }, "<Leader>p", '"+p', { noremap = true, silent = false })

-- Put from system keyboard above
vim.keymap.set({ "n", "v" }, "<Leader>P", '"+P', { noremap = true, silent = false })

-- Remap for dealing with word wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Don't copy the replaced text after pasting in visual mode
vim.keymap.set("v", "p", '"_dp', opts)
vim.keymap.set("v", "P", '"_dP', opts)
vim.keymap.set("n", "x", '"_x', opts)

-- Better indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Keep search centered
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)
vim.keymap.set("n", "J", "mzJ`z", opts)

-- Move current line/selection in visual mode
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", opts)

-- Going to next item on quickfixlist
vim.keymap.set("n", "]q", "<CMD>cnext<CR>zz", opts)
vim.keymap.set("n", "[q", "<CMD>cprev<CR>zz", opts)

-- Visually select last pasted
vim.keymap.set("n", "gV", "`[v`]", opts)

-- Escape in terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", opts)

-- Toggle colorcolumn
local function toggle_colorcolumn()
    if vim.wo.colorcolumn == "" then
        vim.wo.colorcolumn = "80"
    else
        vim.wo.colorcolumn = ""
    end
end
vim.keymap.set("n", "<Leader>oc", toggle_colorcolumn, opts)

-- Toggle relative line numbers
local function toggle_relative_ln()
    if vim.wo.relativenumber == true then
        vim.wo.relativenumber = false
    else
        vim.wo.relativenumber = true
    end
end
vim.keymap.set("n", "<Leader>or", toggle_relative_ln, opts)

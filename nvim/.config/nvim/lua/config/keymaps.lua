-- Options Table
local opts = { noremap = true, silent = true }

-- Unbind Space (Leader)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", opts)

-- Disable useless binding
vim.keymap.set({ "n", "v" }, "Q", "<Nop>", opts)

-- Use ESC to turn off search highlighting
vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>", opts)

-- Remap window actions
vim.keymap.set({ "n", "v" }, "<Leader>w", "<C-w>", opts)

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = false })

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

-- Switch between buffers
vim.keymap.set("n", "[b", "<Cmd>bprevious<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })
vim.keymap.set("n", "]b", "<Cmd>bnext<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })

-- Going to next item on quickfixlist
vim.keymap.set("n", "]q", "<Cmd>cnext<CR>zz", { noremap = true, silent = true, desc = "Next Quickfix" })
vim.keymap.set("n", "[q", "<Cmd>cprev<CR>zz", { noremap = true, silent = true, desc = "Next Quickfix" })

-- Highlight last copied text
vim.keymap.set("n", "gp", "`[v`]", { noremap = true, silent = true, desc = "Highlight last pasted text" })

-- Toggle colorcolumn
vim.keymap.set(
    "n",
    "<Leader>oc",
    function()
        if vim.wo.colorcolumn == "" then
            vim.wo.colorcolumn = "80"
        else
            vim.wo.colorcolumn = ""
        end
    end,
    { noremap = true, silent = true, desc = "Toggle colorcolumn" }
)

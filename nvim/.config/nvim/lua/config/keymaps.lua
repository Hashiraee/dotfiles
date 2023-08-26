-- Options Table
local opts = { noremap = true, silent = true }

-- Unbind Space (Leader)
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", opts)

-- Disable useless binding
vim.keymap.set({ "n", "v" }, "Q", "<Nop>", opts)

-- Use ESC to turn off search highlighting
vim.keymap.set("n", "<Esc>", ":noh<CR>", opts)

-- Remap window actions
vim.keymap.set({ "n", "v" }, "<Leader>w", "<C-w>", opts)

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<Leader>y", '"+y', { noremap = true, silent = false })

-- Put from system clipboard below
vim.keymap.set("n", "<Leader>p", '"+p', { noremap = true, silent = false })

-- Put from system keyboard above
vim.keymap.set("n", "<Leader>P", '"+P', { noremap = true, silent = false })

-- Remap for dealing with word wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Don't copy the replaced text after pasting in visual mode
vim.keymap.set('v', 'p', '"_dp', opts)
vim.keymap.set('v', 'P', '"_dP', opts)
vim.keymap.set('n', 'x', '"_x', opts)

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
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { noremap = true, silent = true, desc = "Previous Buffer"})
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { noremap = true, silent = true, desc = "Previous Buffer"})

-- Saving with leader s
vim.keymap.set("n", "<Leader>s", "<cmd>w<cr>", { noremap = true, silent = true, desc = "Save"})

-- Harpoon stuff
--  vim.keymap.set('n', '<Leader>ha', function() require("harpoon.mark").add_file() end, opts)
--  vim.keymap.set('n', '<Leader>hh', function() require("harpoon.ui").toggle_quick_menu() end, opts)
--
--  vim.keymap.set('n', "<C-j>", function() require("harpoon.ui").nav_file(1) end, opts)
--  vim.keymap.set('n', "<C-k>", function() require("harpoon.ui").nav_file(2) end, opts)
--  vim.keymap.set('n', "<C-l>", function() require("harpoon.ui").nav_file(3) end, opts)
--  vim.keymap.set('n', "<C-;>", function() require("harpoon.ui").nav_file(4) end, opts)

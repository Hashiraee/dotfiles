-- Options
local opts = { noremap = true, silent = true }

-- Unbind Space
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- Remap window actions
vim.keymap.set({ 'n', 'v' }, '<Leader>w', '<C-w>', opts)

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<Leader>y', '"+y', { noremap = true, silent = false })

-- Put from system clipboard below
vim.keymap.set('n', '<Leader>p', '"+p', { noremap = true, silent = false })

-- Put from system keyboard above
vim.keymap.set('n', '<Leader>P', '"+P', { noremap = true, silent = false })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Don't copy the replaced text after pasting in visual mode
vim.keymap.set('v', 'p', '"_dp', opts)
vim.keymap.set('v', 'P', '"_dP', opts)
vim.keymap.set('n', 'x', '"_x', opts)

-- Weird behavior in select mode
vim.keymap.set('s', 'p', 'p', opts)

-- Better indenting
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Use ESC to turn off search highlighting
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- Keep search centered
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
vim.keymap.set('n', 'J', 'mzJ`z', opts)

-- Close all buffers except current
vim.keymap.set('n', '<Leader>o', '<Cmd>%bd|e#|bd#<CR>', opts)

-- Move current line/selection in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

vim.keymap.set('s', 'J', 'J', opts)
vim.keymap.set('s', 'K', 'K', opts)

-- Disable useless binding
vim.keymap.set('n', 'Q', '<Nop>', opts)

-- Map :W to :w
vim.api.nvim_create_user_command("W", ":w", {})

-- Map :Q to :q
vim.api.nvim_create_user_command("Q", ":q", {})

-- Move between buffers
vim.keymap.set('n', 'gn', '<Cmd>bnext<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>bprev<CR>', opts)

-- Telescope
vim.keymap.set('n', '<Leader>gs', '<Cmd>Telescope git_status<CR>', opts)
vim.keymap.set('n', '<Leader>gc', '<Cmd>Telescope git_commits<CR>', opts)
vim.keymap.set('n', '<Leader>f', '<Cmd>Telescope find_files<CR>', opts)
vim.keymap.set('n', '<Leader>sb', '<Cmd>Telescope buffers<CR>', opts)
vim.keymap.set('n', '<Leader>sh', '<Cmd>Telescope help_tags<CR>', opts)
vim.keymap.set('n', '<Leader>sg', '<Cmd>Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<Leader>ss', '<Cmd>Telescope grep_string<CR>', opts)
vim.keymap.set('n', '<Leader>sc', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', opts)
vim.keymap.set('n', '<Leader>sd', '<Cmd>Telescope lsp_document_symbols<CR>', opts)
vim.keymap.set('n', '<Leader>sw', '<Cmd>Telescope lsp_workspace_symbols<CR>', opts)

-- Harpoon
vim.keymap.set('n', '<Leader>ha', function() require("harpoon.mark").add_file() end, opts)
vim.keymap.set('n', '<Leader>hh', function() require("harpoon.ui").toggle_quick_menu() end, opts)

vim.keymap.set('n', "<C-j>", function() require("harpoon.ui").nav_file(1) end, opts)
vim.keymap.set('n', "<C-k>", function() require("harpoon.ui").nav_file(2) end, opts)
vim.keymap.set('n', "<C-l>", function() require("harpoon.ui").nav_file(3) end, opts)
vim.keymap.set('n', "<C-;>", function() require("harpoon.ui").nav_file(4) end, opts)

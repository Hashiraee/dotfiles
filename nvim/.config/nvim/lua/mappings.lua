-- Options
local opts = { noremap = true, silent = true }

-- Don't copy the replaced text after pasting in visual mode
vim.keymap.set('v', 'p', '"_dP', opts)
vim.keymap.set('n', 'x', '"_x', opts)

-- Better Yank to end of line
vim.keymap.set('n', 'Y', 'y$', opts)

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<Leader>y', '"+y', { noremap = true, silent = false })

-- Put from system clipboard below
vim.keymap.set('n', '<Leader>p', '"+p', { noremap = true, silent = false })

-- Put from system keyboard above
vim.keymap.set('n', '<Leader>p', '"+P', { noremap = true, silent = false })

-- Unmap space in normal mode
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap weird behaviour select-mode
vim.keymap.set('s', 'p', 'p', opts)

-- Better indenting
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Move current line(s) in normal mode
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==', opts)
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==', opts)

-- Move current line/selection in insert mode
vim.keymap.set('i', '<M-j>', "<Esc>:m .+1<CR>==gi", opts)
vim.keymap.set('i', '<M-k>', "<Esc>:m .-2<CR>==gi", opts)

-- Move current line/selection in visual mode
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv-gv", opts)
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv-gv", opts)

-- Use ESC to turn off search highlighting
vim.keymap.set('n', '<Esc>', ':noh<CR>', opts)

-- Keep search centered
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)
vim.keymap.set('n', 'J', 'mzJ`z', opts)

-- Disable useless binding
vim.keymap.set('n', 'Q', '<Nop>', opts)

-- Close all buffers except current
vim.keymap.set('n', '<Leader>o', '<Cmd>%bd|e#|bd#<CR>', opts)

-- Telescope
vim.keymap.set('n', '<Leader>gs', '<Cmd>Telescope git_status<CR>', opts)
vim.keymap.set('n', '<Leader>gc', '<Cmd>Telescope git_commits<CR>', opts)
vim.keymap.set('n', '<Leader>f', '<Cmd>Telescope find_files<CR>', opts)
vim.keymap.set('n', '<Leader>b', '<Cmd>Telescope buffers<CR>', opts)
vim.keymap.set('n', '<Leader>h', '<Cmd>Telescope help_tags<CR>', opts)
vim.keymap.set('n', '<Leader>\\', '<Cmd>Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<Leader>l', '<Cmd>Telescope grep_string<CR>', opts)
vim.keymap.set('n', '<Leader>c', '<Cmd>Telescope current_buffer_fuzzy_find<CR>', opts)
vim.keymap.set('n', '<Leader>s', '<Cmd>Telescope lsp_document_symbols<CR>', opts)
vim.keymap.set('n', '<Leader>S', '<Cmd>Telescope lsp_workspace_symbols<CR>', opts)

-- Move between tabs
vim.keymap.set('n', 'gn', '<Cmd>BufferLineCycleNext<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>BufferLineCyclePrev<CR>', opts)

-- Go to the end of file
vim.keymap.set({ 'n', 'v' }, 'ge', 'G', opts)

-- Go to the begin of line
vim.keymap.set({ 'n', 'v' }, 'gh', '0', opts)

-- Go to end of line
vim.keymap.set({ 'n', 'v' }, 'gl', '$', opts)

-- Go the begin first non-blank character
vim.keymap.set({ 'n', 'v' }, 'gs', '^', opts)

-- Remap window actions
vim.keymap.set({ 'n', 'v' }, '<Leader>w', '<C-w>', opts)

-- Mapping to insert newline in normal mode
vim.keymap.set('n', '[<Leader>', 'O<Esc>', opts)
vim.keymap.set('n', ']<Leader>', 'o<Esc>', opts)

-- Map :W to :w
vim.api.nvim_create_user_command("W", ":w", {})

-- Map :Q to :q
vim.api.nvim_create_user_command("Q", ":q", {})

-- Convenient
vim.keymap.set('n', '<leader>;', ':')

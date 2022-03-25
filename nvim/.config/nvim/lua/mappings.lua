local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- Don't copy the replaced text after pasting in visual mode
map('v', 'p', '"_dP', opt)
map('n', 'x', '"_x', opt)

-- Better Yank to end of line
map('n', 'Y', 'y$', opt)

-- Undo command with U
map('n', 'U', '<C-r>', opt)

-- Unmap space in normal mode
map('n', '<Space>', '', opt)

-- Remap weird behaviour select-mode
map('s', 'p', 'p', opt)

-- Use leader w to write
map('n', '<Leader>w', '<cmd>w<Cr>', opt)

-- With leader
map('n', '<Leader>h', '<C-w><C-h>', opt)
map('n', '<Leader>j', '<C-w><C-j>', opt)
map('n', '<Leader>k', '<C-w><C-k>', opt)
map('n', '<Leader>l', '<C-w><C-l>', opt)

-- Better window placement
map('n', '<Leader>H', '<C-w>H', opt)
map('n', '<Leader>J', '<C-w>J', opt)
map('n', '<Leader>K', '<C-w>K', opt)
map('n', '<Leader>L', '<C-w>L', opt)

-- Resize windows
-- map('n', '', ':resize -2<CR>', opt)
-- map('n', '', ':resize +2<CR>', opt)
-- map('n', '', ':vertical resize -2<CR>', opt)
-- map('n', '', ':vertical resize +2<CR>', opt)

-- Better indenting
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)

-- Move current line(s) in normal mode
map('n', '<M-j>', ':m .+1<CR>==', opt)
map('n', '<M-k>', ':m .-2<CR>==', opt)

-- Move current line/selection in visual mode
map('v', '<M-j>', ":m '>+1<CR>gv-gv", opt)
map('v', '<M-k>', ":m '<-2<CR>gv-gv", opt)

-- Keep search centered
map('n', 'n', 'nzzzv', opt)
map('n', 'N', 'Nzzzv', opt)
map('n', 'J', 'mzJ`z', opt)

-- Disable useless binding
map('n', 'Q', '', opt)

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>', opt)

-- Telescope
map('n', '<Leader>gs', ':Telescope git_status <CR>', opt)
map('n', '<Leader>gc', ':Telescope git_commits <CR>', opt)
map('n', '<Leader>ff', ':Telescope find_files<CR>', opt)
map('n', '<Leader>fb', ':Telescope buffers<CR>', opt)
map('n', '<Leader>fh', ':Telescope help_tags<CR>', opt)
map('n', '<Leader>fo', ':Telescope oldfiles<CR>', opt)
map('n', '<Leader>fg', ':Telescope live_grep<CR>', opt)
map('n', '<Leader>fc', ':Telescope current_buffer_fuzzy_find<CR>', opt)

-- Move between tabs
map('n', '<M-p>', ':BufferLineCyclePrev<CR>', opt)
map('n', '<M-n>', ':BufferLineCycleNext<CR>', opt)

-- Use ESC to turn off search highlighting
map('n', '<Esc>', ':noh<CR>', opt)

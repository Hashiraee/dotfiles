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

-- Unmap space in normal mode
map('n', '<Space>', '', opt)

-- Remap weird behaviour select-mode
map('s', 'p', 'p', opt)

-- With comma remap windows
map('n', ',h', '<C-w><C-h>', opt)
map('n', ',j', '<C-w><C-j>', opt)
map('n', ',k', '<C-w><C-k>', opt)
map('n', ',l', '<C-w><C-l>', opt)

-- Remap ,, to ,
map('n', ',,', ',', opt)

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

-- Move current line/selection in insert mode
map('i', '<M-j>', "<Esc>:m .+1<CR>==gi", opt)
map('i', '<M-k>', "<Esc>:m .-2<CR>==gi", opt)

-- Move current line/selection in visual mode
map('v', '<M-j>', ":m '>+1<CR>gv-gv", opt)
map('v', '<M-k>', ":m '<-2<CR>gv-gv", opt)

-- Use ESC to turn off search highlighting
map('n', '<Esc>', ':noh<CR>', opt)

-- Keep search centered
map('n', 'n', 'nzzzv', opt)
map('n', 'N', 'Nzzzv', opt)
map('n', 'J', 'mzJ`z', opt)

-- Disable useless binding
map('n', 'Q', '', opt)

-- Map :W to :w
-- vim.api.nvim_add_user_command("W", ":w", {})

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
map('n', '<Tab>', ':BufferLineCyclePrev<CR>', opt)
map('n', '<S-Tab>', ':BufferLineCycleNext<CR>', opt)

-- Vimtex
map('n', '<C-S>', ':VimtexCompile<CR>', opt)

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

-- Yank to system clipboard
map('v', '<Leader>y', '"*y', {noremap = true, silent = false})
map('n', '<Leader>y', '"*y', {noremap = true, silent = false})

-- Put from system clipboard below
map('n', '<Leader>p', '"*p', {noremap = true, silent = false})

-- Put from system keyboard above
map('n', '<Leader>p', '"*P', {noremap = true, silent = false})

-- Unmap space in normal mode
map('n', '<Space>', '', opt)

-- Remap weird behaviour select-mode
map('s', 'p', 'p', opt)

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

-- Close all buffers except current
map('n', '<Leader>o', '<Cmd>%bd|e#|bd#<CR>', opt)

-- Telescope
map('n', '<Leader>gs', ':Telescope git_status <CR>', opt)
map('n', '<Leader>gc', ':Telescope git_commits <CR>', opt)
map('n', '<Leader>f', ':Telescope find_files<CR>', opt)
map('n', '<Leader>b', ':Telescope buffers<CR>', opt)
map('n', '<Leader>h', ':Telescope help_tags<CR>', opt)
map('n', '<Leader>\\', ':Telescope live_grep<CR>', opt)
map('n', '<Leader>l', ':Telescope grep_string<CR>', opt)
map('n', '<Leader>c', ':Telescope current_buffer_fuzzy_find<CR>', opt)
map('n', '<Leader>s', ':Telescope lsp_document_symbols<CR>', opt)
map('n', '<Leader>S', ':Telescope lsp_workspace_symbols<CR>', opt)

-- Move between tabs
map('n', 'gn', ':BufferLineCycleNext<CR>', opt)
map('n', 'gp', ':BufferLineCyclePrev<CR>', opt)

-- Go to the end of file
map('n', 'ge', 'G', opt)

-- Go to the begin of line
map('n', 'gh', '0', opt)

-- Go to end of line
map('n', 'gl', '$', opt)

-- Go the begin first non-blank character
map('n', 'gs', '^', opt)

-- Remap window actions
map('n', '<Leader>w', '<C-w>', opt)

-- Mapping to insert newline in normal mode
map('n', '[<Leader>', 'O<Esc>', opt)
map('n', ']<Leader>', 'o<Esc>', opt)

-- Map :W to :w
-- vim.api.nvim_add_user_command("W", ":w", {})

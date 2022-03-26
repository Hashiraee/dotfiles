local opt = vim.opt
local g = vim.g

opt.hidden = true
opt.ruler = false

opt.ignorecase = true
opt.smartcase = true

opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.cursorline = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 250 -- Update interval for gitsigns
opt.timeoutlen = 400

-- Netrw options
g.netrw_banner = 0
g.netrw_liststyle = 1
g.netrw_browse_split = 4
g.netrw_altv = 1
g.netrw_winsize = 30

-- File encoding and language
opt.fileencoding = 'utf-8'
opt.spelllang = 'en_us'

-- Disable startup screen
opt.shortmess:append("sI")

-- Disable tilde on end of buffer
vim.cmd("let &fcs='eob: '")

-- Numbers
opt.number = true
opt.numberwidth = 4
opt.relativenumber = true
opt.showmode = false

-- Indentline
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4

-- Complete options
opt.completeopt = 'menuone,noinsert,noselect'

-- Backup options
opt.swapfile = false
opt.backup = false

-- Set python3 provider
g.python3_host_prog="/usr/local/bin/python3"

-- highlight yank
vim.cmd[[
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=false}
]]

-- Set undodir and directory
local undodir = os.getenv("HOME") .. '/.local/share/nvim/undodir'
os.execute("mkdir -p " .. undodir)
opt.undodir = undodir
vim.cmd('set undofile')

-- Normal h and l use when wrapping around long line
opt.whichwrap:append("<>hl")

-- Mapping leader key to space
g.mapleader = " "
g.maplocalleader = " "

local M = {}
function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end
return M

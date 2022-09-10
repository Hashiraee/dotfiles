local opt = vim.opt
local g = vim.g

-- Set leader key
g.mapleader = " "

-- Scrolloff
opt.scrolloff = 8

-- highlight while searching
opt.incsearch = true

-- Indentline
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smarttab = true

-- Options for long lines
opt.wrap = false
opt.breakindent = true

-- Indent options
opt.smartindent = true
opt.autoindent = true

-- Set global statusline
opt.laststatus = 3

-- File encoding and language
opt.fileencoding = "utf-8"
opt.spelllang = "en_us"

-- Show incremential command
opt.inccommand = "split"

-- Disable ruler
opt.ruler = false

-- Text options
opt.ignorecase = true
opt.smartcase = true

-- Better split behaviour
opt.splitbelow = true
opt.splitright = true

-- Terminal colors
opt.termguicolors = true

-- Cursorline
opt.cursorline = true

-- Set numbers
opt.nu = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- Command hight
opt.cmdheight = 1

-- Timing
opt.updatetime = 200
opt.timeoutlen = 400

-- Enable mouse
opt.mouse = "a"

-- Disable Errorbells
opt.errorbells = false

-- Disable showmode
opt.showmode = false

-- Complete options
opt.completeopt = 'menuone,noinsert,noselect'

-- Backup options
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
opt.undofile = true

-- Set python3 provider
g.python3_host_prog="/usr/bin/python3"

-- Netrw options
g.netrw_banner = 0
g.netrw_liststyle = 1
g.netrw_browse_split = 4
g.netrw_altv = 1
g.netrw_winsize = 30

-- Disable startup screen
opt.shortmess:append("I")

-- Disable tilde on end of buffer
opt.fillchars = 'eob: '

-- Normal h and l use when wrapping around long line
opt.whichwrap:append("<>hl")

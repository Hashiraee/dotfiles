-- Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better terminal colors
vim.opt.termguicolors = true

-- Tab expands to spaces
vim.opt.expandtab = true

-- Tab options
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smarttab = true

-- Indent Options
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.shiftround = true

-- More natural split options
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Scroll off
vim.opt.scrolloff = 8

-- Highlight while searching
vim.opt.incsearch = true

-- Update time
vim.opt.updatetime = 100

-- No line wrapping
vim.opt.wrap = false

-- Set status line
vim.opt.laststatus = 2

-- File encoding and language
vim.opt.fileencoding = "utf-8"
vim.opt.spelllang = "en_us"

-- Show incremental updates of command
vim.opt.inccommand = "split"

-- Disable ruler
vim.opt.ruler = false

-- Text options for searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set cursor line
vim.opt.cursorline = true

-- Show sign column
vim.opt.signcolumn = "yes"

-- Set number and relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- Command height option
vim.opt.cmdheight = 1

-- Wait for key presses
vim.opt.timeoutlen = 300

-- Enable mouse
vim.opt.mouse = "a"

-- Disable Error bells
vim.opt.errorbells = false

-- Complete options
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.wildmode = "longest:full,full"

-- Pop-up blend
vim.opt.pumblend = 10

-- Maximum entries in completion list.
vim.opt.pumheight = 10

-- Disable mode
vim.opt.showmode = false

-- Show hidden characters
vim.opt.list = false

-- Grep program
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"

-- Backup options
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- Normal h and l use when wrapping around long line
vim.opt.whichwrap:append("<>hl")

vim.opt.shortmess:append { W = true, I = true, c = true }

-- Set python3 provider
vim.g.python3_host_prog="/usr/bin/python3"

-- Netrw options
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 30

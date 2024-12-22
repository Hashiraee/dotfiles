-- Remap space as leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Add border
vim.o.winborder = "rounded"

-- Better terminal colors
vim.o.termguicolors = true

-- Tab expands to spaces
vim.o.expandtab = true

-- Tab options
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.smarttab = true

-- Indent Options
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.breakindent = true
vim.o.shiftround = true

-- More natural split options
vim.o.splitbelow = true
vim.o.splitright = true

-- Scroll off
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Highlight while searching
vim.o.incsearch = true

-- Update time
vim.o.updatetime = 100

-- No line wrapping
vim.o.wrap = false

-- Set status line
vim.o.laststatus = 2

-- File encoding and language
vim.o.fileencoding = "utf-8"
vim.o.spelllang = "en_us"

-- Show incremental updates of command
vim.o.inccommand = "split"

-- Disable ruler
vim.o.ruler = false

-- Text options for searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set cursor line
vim.o.cursorline = true

-- Show sign column
vim.o.signcolumn = "yes"

-- Set number and relative number
vim.o.number = true
vim.o.relativenumber = true

-- Command height option
vim.o.cmdheight = 1

-- Wait for key presses
vim.o.timeoutlen = 300

-- Enable mouse
vim.o.mouse = "a"

-- Disable Error bells
vim.o.errorbells = false

-- Complete options
vim.o.completeopt = "menu,menuone,noselect"
vim.o.wildmode = "longest:full,full"

-- -- Pop-up blend
vim.o.pumblend = 0
vim.o.winblend = 0

-- Maximum entries in completion list.
vim.o.pumheight = 10

-- Disable mode
vim.o.showmode = false

-- Show hidden characters
vim.o.list = false

-- Grep program
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"

-- Backup options
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.o.undofile = true
vim.o.undolevels = 10000

-- Normal h and l use when wrapping around long line
vim.opt.whichwrap:append("<>hl")

vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

-- Set python3 provider
vim.g.python3_host_prog="/usr/bin/python3"

-- Netrw options
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 1
vim.g.netrw_browse_split = 0
vim.g.netrw_altv = 1
vim.g.netrw_winsize = 30

vim.o.formatoptions = "jcroqlnt" -- tcqj
vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep"

-- Allow cursor to move where there is no text in visual block mode
vim.o.virtualedit = "block"

-- Minimum window width
vim.o.winminwidth = 5

-- No tilde symbols
vim.opt.fillchars = { eob = " " }

-- Disable cursor blinking in terminal mode
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:block-TermCursor'

-- Extend path
vim.opt.path:append("**")

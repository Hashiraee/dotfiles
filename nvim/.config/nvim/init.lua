-- Impatient
require('impatient')

-- Basic settings
require('options')
require('mappings')
require('globals')
require('utils').hide()

-- LSP
require('lsp')

-- Colorscheme
require('colorscheme')

-- Plugins
require('pluginslist')

-- Treesitter
require('plugins/treesitter')

-- Telescope
require('plugins/telescope')

-- Completion
require('plugins/cmp')
require('plugins/autopairs')

-- Nvim File Tree
require('plugins/nvimtree')

-- Buffers / Tabs
require('plugins/bufferline')

-- Statusline
require('plugins/statusline')

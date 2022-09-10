-- Options: latte, frappe, macchiato, mocha
vim.g.catppuccin_flavour = "mocha"

require("catppuccin").setup()

vim.cmd [[colorscheme catppuccin]]

-- One hightlight
vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#cdd6f4', bold = true })

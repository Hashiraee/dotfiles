local Plugin = { 'akinsho/toggleterm.nvim' }

Plugin.event = "VeryLazy"

Plugin.keys = { '<C-`>' }

Plugin.opts = {
    open_mapping = '<C-`>',
    direction = 'horizontal',
    shade_terminals = true,
}

return Plugin

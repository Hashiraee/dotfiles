local Plugin = { "lukas-reineke/indent-blankline.nvim" }

Plugin.name = "indent_blankline"

Plugin.event = { "BufReadPost", "BufNewFile" }

Plugin.opts = {
    char = "│",
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    use_treesitter = true,
    show_current_context = false,
    filetype_exclude = { "help", "alpha", "dashboard", "lazy", "mason", "NvimTree", "qf" },
}

return Plugin

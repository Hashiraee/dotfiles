local present, indent_blankline = pcall(require, "indent_blankline")
if not present then
    print("Something wrong with indent-blankine configuration...")
    return
end

indent_blankline.setup {
    show_trailing_blankline_indent = false,
    show_end_of_line = false,
    use_treesitter = true,

    filetype_exclude = { "help", "packer" },
    buftype_exclude = { "terminal", "nofile", "toggleterm" },
}

local present, bufferline = pcall(require, "bufferline")
if not present then
    return
end

bufferline.setup
{
    options =
    {
        offsets = {{filetype = "NvimTree", text = "File Explorer", padding = 1}},
        modified_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = "thin",
        always_show_bufferline = true
    },
}

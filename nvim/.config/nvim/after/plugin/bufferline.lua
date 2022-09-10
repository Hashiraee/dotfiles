local status, bufferline = pcall(require, "bufferline")
if not status then
    return
end


bufferline.setup {
    options = {
        mode = "buffers",
        numbers = "none",
        close_command = "bdelete! %d",

        indicator = {
            icon = '▎', -- This should be omitted if indicator style is not 'icon'
            style = 'none',
        },

        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',

        -- Length of filenames
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,

        -- Diagnostics
        diagnostics = false,
        diagnostics_update_in_insert = false,

        -- Icons on tabs
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_buffer_default_icon = false,
        show_close_icon = false,
        show_tab_indicators = true,

        -- Whether or not custom sorted buffers should persist
        persist_buffer_sort = true,

        separator_style = "slant",
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        sort_by = 'insert_at_end',
    },
}

local status, bufferline = pcall(require, "bufferline")
if not status then
    return
end


bufferline.setup {
    highlights = require("catppuccin.groups.integrations.bufferline").get(),

    options = {
        mode = "buffers",
        numbers = "none",
        close_command = "bdelete! %d",

        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',

        -- Diagnostics
        diagnostics = false,
        diagnostics_update_in_insert = false,

        -- Icons on tabs
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,

        sort_by = 'insert_at_end',
    },
}

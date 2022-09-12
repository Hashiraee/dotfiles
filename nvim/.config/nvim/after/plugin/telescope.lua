local status, telescope = pcall(require, "telescope")
if not status then
    return
end

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },

        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",

        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.50,
                results_width = 0.8
            },

            vertical = {
                mirror = false
            },

            width = 0.85,
            height = 0.80,
            preview_cutoff = 120
        },

        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,

        file_ignore_patterns = {
            "%.class", "target/*", "%.lock","%.fls", "%.log", "%.aux",
            "%.pdf", "%.gz", "%.fdb*",
        },

        path_display = { "absolute" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"},

        mappings = {
            i = {},
        },
    },

    pickers = {
        current_buffer_fuzzy_find = {
            theme = "dropdown",
            previewer = false,
        },

        buffers = {
            theme = "dropdown",
            previewer = false,
        },
    },

    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        },

        file_browser = {
            theme = "dropdown",

            -- Disables netrw and use telescope-file-browser in its place
            hijack_netrw = false,

            mappings = {
                ["i"] = {

                },

                ["n"] = {

                },
            },
        },

    },
}

telescope.load_extension("fzf")
telescope.load_extension("harpoon")
telescope.load_extension("file_browser")

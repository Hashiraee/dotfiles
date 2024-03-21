local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.name = "telescope"

Plugin.opts = {
    defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.85,
            height = 0.80,
            preview_cutoff = 120,
        },
        file_ignore_patterns = { "node_modules", "env", "venv" },
        path_display = { "truncate" },
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
    },

    pickers = {
        find_files = {},

        live_grep = {},

        buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
                n = {
                    ["dd"] = "delete_buffer"
                },
            },
        },

        oldfiles = {
            theme = "dropdown",
            previewer = false,
        },

        current_buffer_fuzzy_find = {
            theme = "dropdown",
            previewer = false,
        },
    },

    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },

        file_browser = {
            theme = "dropdown",
            hijack_netrw = true,
            initial_mode = "normal",
        },
    },
}

Plugin.dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-file-browser.nvim" },
}

Plugin.cmd = { "Telescope" }

function Plugin.init()
    vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope find_files<cr>")
    vim.keymap.set("n", "<Leader>fb", "<Cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<Leader><Leader>", "<Cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<Leader>fg", "<Cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<Leader>fs", "<Cmd>Telescope grep_string<cr>")
    vim.keymap.set("n", "<Leader>fd", "<Cmd>Telescope diagnostics<cr>")
    vim.keymap.set("n", "<Leader>fc", "<Cmd>Telescope current_buffer_fuzzy_find<cr>")
    vim.keymap.set("n", "<Leader>fh", "<Cmd>Telescope help_tags<cr>")
    vim.keymap.set("n", "<Leader>fo", "<Cmd>Telescope oldfiles<cr>")
    vim.keymap.set("n", "<Leader>ft", "<Cmd>Telescope file_browser<cr>")
end

function Plugin.config()
    require("telescope").setup(Plugin.opts)
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
end

return Plugin

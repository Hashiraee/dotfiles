local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.name = "telescope"

Plugin.opts = {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
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
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
    },

    pickers = {
        find_files = {},

        live_grep = {},

        buffers = {
            show_all_buffers = true,
            sort_lastused= true,
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
    },
}

Plugin.dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

Plugin.cmd = { "Telescope" }

function Plugin.init()
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<cr>")
    vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
    vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
    vim.keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>")
end

function Plugin.config()
    require("telescope").setup(Plugin.opts)
    require("telescope").load_extension("fzf")
end

return Plugin

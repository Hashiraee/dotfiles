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
        file_ignore_patterns = {
            ".git",
            ".env",
            "env",
            ".venv",
            ".venv",
            ".pdf",
            ".png",
            ".jpg",
            ".jpeg",
            ".svg",
        },
        path_display = { "truncate" },
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
    },

    pickers = {
        find_files = {},

        git_files = {
            theme = "dropdown",
            previewer = false,
        },

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
    },
}

Plugin.dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

Plugin.cmd = { "Telescope" }

function Plugin.init()
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<Leader>ff", function()
        builtin.find_files({
            hidden = true,
        })
    end)
    vim.keymap.set("n", "<C-p>", function() builtin.git_files({}) end)
    vim.keymap.set("n", "<Leader>fb", function() builtin.buffers({}) end)
    vim.keymap.set("n", "<Leader>fc", function() builtin.current_buffer_fuzzy_find({}) end)
    vim.keymap.set("n", "<Leader>fg", function() builtin.live_grep({}) end)
    vim.keymap.set("n", "<Leader>fs", function() builtin.grep_string({ search = vim.fn.input("Grep > ")}) end)
    vim.keymap.set("n", "<Leader>fd", function() builtin.diagnostics({}) end)
    vim.keymap.set("n", "<Leader>fh", function() builtin.help_tags({}) end)
    vim.keymap.set("n", "<Leader>fo", function() builtin.oldfiles({}) end)
end

function Plugin.config()
    require("telescope").setup(Plugin.opts)
    require("telescope").load_extension("fzf")
end

return Plugin

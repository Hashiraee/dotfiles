local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

function Plugin.config()
    require("telescope").setup({
        defaults = {},

        pickers = {
            find_files = {
                theme = "ivy"
            },

            buffers = {
                theme = "dropdown",
                previewer = false,
                show_all_buffers = true,
                sort_lastused = true,
                mappings = {
                    n = {
                        ["dd"] = "delete_buffer"
                    },
                },
            },

            current_buffer_fuzzy_find = {
                theme = "dropdown",
                previewer = false,
            },

            help_tags = {
                theme = "ivy",
            },

            live_grep = {
                theme = "ivy"
            },
        },

        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            }
        }
    })

    -- Telescope keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<Leader>ff", function() builtin.find_files({ hidden = true }) end)
    vim.keymap.set("n", "<Leader>fn", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end)
    vim.keymap.set("n", "<Leader>fb", function() builtin.buffers() end)
    vim.keymap.set("n", "<Leader>fc", function() builtin.current_buffer_fuzzy_find() end)
    vim.keymap.set("n", "<Leader>fh", function() builtin.help_tags() end)
    vim.keymap.set("n", "<Leader>fg", function() builtin.live_grep() end)
    vim.keymap.set("n", "<Leader>fs", function() builtin.grep_string({ search = vim.fn.input("Grep > ")}) end)
end

return Plugin

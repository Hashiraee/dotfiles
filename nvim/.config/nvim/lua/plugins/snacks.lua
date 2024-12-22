local Plugin = { "folke/snacks.nvim" }

Plugin.dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" },
}

Plugin.priority = 1000

Plugin.lazy = false

Plugin.opts = {
    explorer = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
}

function Plugin.config()
    local snacks = require("snacks")

    -- Options
    local scroll_opts = {
        win = {
            input = {
                keys = {
                    ["<C-u>"] = { "preview_scroll_up", mode = { "n", "i" } },
                    ["<C-d>"] = { "preview_scroll_down", mode = { "n", "i" } },
                },
            },
            list = {
                keys = {
                    ["<C-u>"] = "preview_scroll_up",
                    ["<C-d>"] = "preview_scroll_down",
                },
            },
        },
    }

    -- Fuzzy File Explorer
    vim.keymap.set("n", "<leader>e", function() snacks.explorer({
        win = {
            list = {
                keys = {
                    ["o"] = "confirm",
                },
            },
        },
    }) end)

    -- Scratch Pad
    vim.keymap.set("n", "<leader>.", function() snacks.scratch() end)
    vim.keymap.set("n", "<leader>S", function() snacks.scratch.select() end)

    -- Fuzzy File Finder
    vim.keymap.set("n", "<Leader>ff", function() snacks.picker.files(scroll_opts) end)
    vim.keymap.set("n", "<Leader>fi", function() snacks.picker.files({
        ignored = true,
        hidden = true,
    }) end)
    vim.keymap.set("n", "<Leader>fb", function() snacks.picker.buffers({
        win = {
            input = {
                keys = {
                    ["dd"] = { "bufdelete", mode = { "n", "i" } },
                },
            },
            list = {
                keys = {
                    ["dd"] = "bufdelete",
                },
            },
        },
    }) end)
    vim.keymap.set("n", "<Leader>/", function() snacks.picker.grep() end)
    vim.keymap.set("n", "<Leader>:", function() snacks.picker.command_history() end)
    vim.keymap.set("n", "<Leader>fc", function()
        snacks.picker.files(vim.tbl_extend("force", { cwd = vim.fn.stdpath("config") }, scroll_opts))
    end)
    vim.keymap.set("n", "<Leader>fd", function()
        snacks.picker.files(vim.tbl_extend("force", { cwd = vim.fs.normalize("~/Downloads") }, scroll_opts))
    end)
    vim.keymap.set("n", "<leader>fg", function() snacks.picker.git_files() end)

    -- Fuzzy Grep Finder
    vim.keymap.set("n", "<leader>sc", function() snacks.picker.lines() end)
    vim.keymap.set("n", "<leader>sb", function() snacks.picker.grep_buffers() end)
    vim.keymap.set("n", "<leader>sg", function() snacks.picker.grep() end)
    vim.keymap.set("n", "<leader>sw", function() snacks.picker.grep_word() end)
    vim.keymap.set("n", "<leader>su", function() snacks.picker.undo() end)
    vim.keymap.set("n", "<leader>sq", function() snacks.picker.qflist() end)
    vim.keymap.set("n", "<leader>sl", function() snacks.picker.loclist() end)
    vim.keymap.set("n", "<leader>sh", function() snacks.picker.help() end)
    vim.keymap.set("n", "<leader>sH", function() snacks.picker.highlights() end)
    vim.keymap.set("n", "<leader>sd", function() snacks.picker.diagnostics() end)
    vim.keymap.set("n", "<leader>sD", function() snacks.picker.diagnostics_buffer() end)

    -- Fuzzy Git Finder
    vim.keymap.set("n", "<leader>gb", function() snacks.picker.git_branches() end)
    vim.keymap.set("n", "<leader>gl", function() snacks.picker.git_log() end)
    vim.keymap.set("n", "<leader>gs", function() snacks.picker.git_status() end)
    vim.keymap.set("n", "<leader>gd", function() snacks.picker.git_diff() end)
    vim.keymap.set({ "n", "v" }, "<leader>go", function() snacks.gitbrowse() end)

    -- LSP Picker
    vim.keymap.set("n", "<leader>ss", function() snacks.picker.lsp_symbols() end)
    vim.keymap.set("n", "<leader>sS", function() snacks.picker.lsp_workspace_symbols() end)

    -- Theme Changer
    vim.keymap.set("n", "<leader>ot", function() snacks.picker.colorschemes() end)
end

return Plugin

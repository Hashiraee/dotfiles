local Plugin = { "nvim-telescope/telescope.nvim" }

Plugin.name = "telescope"

Plugin.event = "VeryLazy"

Plugin.opts = {
    defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
    },
}

Plugin.dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make"},
}

Plugin.cmd = { "Telescope" }

function Plugin.init()
    vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
    vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
    vim.keymap.set("n", "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
    vim.keymap.set("n", "<leader>?", "<cmd>Telescope oldfiles<cr>")
end


function Plugin.config()
    require("telescope").setup(Plugin.opts)
    require("telescope").load_extension("fzf")
end

return Plugin

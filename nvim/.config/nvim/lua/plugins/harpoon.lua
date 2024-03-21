local Plugin = { "ThePrimeagen/harpoon", branch = "harpoon2" }

function Plugin.config()
    local harpoon = require("harpoon")

    -- Setup
    harpoon:setup({
        settings = {
            save_on_toggle = true,
            sync_on_ui_close = false,
        }
    })

    -- Keymaps
    vim.keymap.set("n", "<Leader>ha", function() harpoon:list():append() end)
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<Leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<Leader>hp", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<Leader>hn", function() harpoon:list():next() end)
end

return Plugin

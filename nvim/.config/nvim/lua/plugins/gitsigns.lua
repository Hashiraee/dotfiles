local Plugin = { "lewis6991/gitsigns.nvim" }

function Plugin.config()
    local gitsigns = require("gitsigns")
    gitsigns.setup({
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local opts = { buffer = bufnr }

            -- Navigation
            vim.keymap.set("n", "]c", function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gs.next_hunk() end)
                return "<Ignore>"
            end, { expr = true, buffer = bufnr })

            vim.keymap.set("n", "[c", function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gs.prev_hunk() end)
                return "<Ignore>"
            end, { expr = true, buffer = bufnr })

            -- Actions
            vim.keymap.set("n", "<Leader>hs", gs.stage_hunk, opts)
            vim.keymap.set("n", "<Leader>hr", gs.reset_hunk, opts)
            vim.keymap.set("v", "<Leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
            vim.keymap.set("v", "<Leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts)
            vim.keymap.set("n", "<Leader>hS", gs.stage_buffer, opts)
            vim.keymap.set("n", "<Leader>hu", gs.undo_stage_hunk, opts)
            vim.keymap.set("n", "<Leader>hR", gs.reset_buffer, opts)
            vim.keymap.set("n", "<Leader>hp", gs.preview_hunk, opts)
            vim.keymap.set("n", "<Leader>hb", function() gs.blame_line({ full = true }) end, opts)
            vim.keymap.set("n", "<Leader>tb", gs.toggle_current_line_blame, opts)
            vim.keymap.set("n", "<Leader>hd", gs.diffthis, opts)
            vim.keymap.set("n", "<Leader>hD", function() gs.diffthis("~") end, opts)
            vim.keymap.set("n", "<Leader>td", gs.toggle_deleted, opts)
        end
    })
end

return Plugin

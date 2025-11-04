--[[
Snacks.nvim Configuration with Multiple Grep Search Support

New Multiple Grep Features:
  <leader>sm  - Multi-pattern grep (OR search)
                Prompts for comma or pipe-separated patterns
                Example: "error, warning, failed" or "error|warning|failed"
                Searches for files containing ANY of the patterns

  <leader>sM  - Multi-grep with word under cursor
                Starts with the word under cursor and allows adding more patterns
                Useful for quickly extending a search

  <leader>sm  - Multi-grep with visual selection (visual mode)
                Starts with the visually selected text and allows adding more patterns
                Great for multi-line or complex pattern base

Usage Examples:
  1. Search for multiple log levels: <leader>sm then type "ERROR, WARN, FATAL"
  2. Search for function variations: <leader>sm then type "handleClick|onClick|clickHandler"
  3. Word under cursor + variants: Position cursor on "user", press <leader>sM, add ", admin, guest"
--]]

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

    -- Multiple Grep Searches
    -- Search for multiple patterns (OR operation - matches ANY pattern)
    vim.keymap.set("n", "<leader>sm", function()
        vim.ui.input({ prompt = "Grep patterns (comma or pipe separated): " }, function(input)
            if input and input ~= "" then
                local patterns
                -- Support both comma and pipe separation
                if input:match("|") then
                    patterns = vim.split(input, "|", { trimempty = true })
                else
                    patterns = vim.split(input, ",", { trimempty = true })
                end

                -- Trim whitespace from each pattern
                for i, pattern in ipairs(patterns) do
                    patterns[i] = vim.trim(pattern)
                end

                if #patterns > 0 then
                    -- Create regex OR pattern for ripgrep
                    local grep_pattern = table.concat(patterns, "|")
                    snacks.picker.grep({ search = grep_pattern })
                end
            end
        end)
    end)

    -- Multi-grep starting with word under cursor
    vim.keymap.set("n", "<leader>sM", function()
        local word = vim.fn.expand("<cword>")
        vim.ui.input({
            prompt = "Add patterns (comma separated, base: " .. word .. "): ",
            default = word
        }, function(input)
            if input and input ~= "" then
                local patterns
                -- Support both comma and pipe separation
                if input:match("|") then
                    patterns = vim.split(input, "|", { trimempty = true })
                else
                    patterns = vim.split(input, ",", { trimempty = true })
                end

                -- Trim whitespace from each pattern
                for i, pattern in ipairs(patterns) do
                    patterns[i] = vim.trim(pattern)
                end

                if #patterns > 0 then
                    -- Create regex OR pattern for ripgrep
                    local grep_pattern = table.concat(patterns, "|")
                    snacks.picker.grep({ search = grep_pattern })
                end
            end
        end)
    end)

    -- Multi-grep with visual selection
    vim.keymap.set("v", "<leader>sm", function()
        -- Get visual selection
        vim.cmd('noau normal! "vy"')
        local selection = vim.fn.getreg("v")
        vim.ui.input({
            prompt = "Add patterns (comma separated, base: " .. selection .. "): ",
            default = selection
        }, function(input)
            if input and input ~= "" then
                local patterns
                -- Support both comma and pipe separation
                if input:match("|") then
                    patterns = vim.split(input, "|", { trimempty = true })
                else
                    patterns = vim.split(input, ",", { trimempty = true })
                end

                -- Trim whitespace from each pattern
                for i, pattern in ipairs(patterns) do
                    patterns[i] = vim.trim(pattern)
                end

                if #patterns > 0 then
                    -- Create regex OR pattern for ripgrep
                    local grep_pattern = table.concat(patterns, "|")
                    snacks.picker.grep({ search = grep_pattern })
                end
            end
        end)
    end)

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

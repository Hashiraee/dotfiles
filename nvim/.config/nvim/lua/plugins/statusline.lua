Plugin = { "nvim-lualine/lualine.nvim" }

Plugin.name = "lualine"

Plugin.event = "VeryLazy"

local assets = {
    left_separator = "",
    right_separator = "",
    bar = "█",
    mode_icon = "",
    dir = "  ",
    file = " ",
    lsp = {
        server = " ",
        error = " ",
        warning = " ",
        info = " ",
        hint = " ",
    },
    git = {
        branch = "󰊢 ",
        added = " ",
        changed = " ",
        removed = " ",
    },
    copilot = " ",
    show_modified = false,
}

local Util = require("util.ui")
local palette = require("rose-pine.palette")
local colors = {
    normal = {
        a = { bg = palette.muted, fg = palette.base, gui = "bold" },
        b = { bg = palette.muted, fg = palette.base },
        c = { bg = palette.muted, fg = palette.base },
    },
    insert = {
        a = { bg = palette.foam, fg = palette.base, gui = "bold" },
        b = { bg = palette.foam, fg = palette.base },
        c = { bg = palette.foam, fg = palette.base },
    },
    visual = {
        a = { bg = palette.iris, fg = palette.base, gui = "bold" },
        b = { bg = palette.iris, fg = palette.base },
        c = { bg = palette.iris, fg = palette.base },
    },
    replace = {
        a = { bg = palette.pine, fg = palette.base, gui = "bold" },
        b = { bg = palette.pine, fg = palette.base },
        c = { bg = palette.pine, fg = palette.base },
    },
    command = {
        a = { bg = palette.love, fg = palette.base, gui = "bold" },
        b = { bg = palette.love, fg = palette.base },
        c = { bg = palette.love, fg = palette.base },
    },
    inactive = {
        a = { bg = palette.gold, fg = palette.base, gui = "bold" },
        b = { bg = palette.gold, fg = palette.base },
        c = { bg = palette.gold, fg = palette.base },
    },
}

Plugin.opts = {
    -- Options
    options = {
        -- theme = vim.g.colors_name,
        theme = colors,
        icons_enabled = true,
        component_separators = { left = assets.left_separator, right = assets.right_separator },
        section_separators = { left = assets.left_separator, right = assets.right_separator },
        disabled_filetypes = {
            statusline = { "NvimTree" },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 300,
        },
    },

    sections = {
        lualine_a = {
            {
                "mode",
                padding = 1,
                color = function()
                    return {
                        gui = "bold",
                    }
                end,
            },
        },

        lualine_b = {
            {
                "branch",
                padding = {
                    left = 1,
                    right = 1,
                },
                icon = {
                    assets.git.branch,
                    seperator = "",
                    padding = {
                        left = 0,
                        right = 0,
                    },
                },
            },
            {
                "diff",
                symbols = {
                    added = assets.git.added,
                    modified = assets.git.changed,
                    removed = assets.git.removed,
                },
                source = function()
                    ---@diagnostic disable-next-line: undefined-field
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                        return {
                            added = gitsigns.added,
                            modified = gitsigns.changed,
                            removed = gitsigns.removed,
                        }
                    end
                end,
                padding = {
                    left = 0,
                    right = 1,
                },
            },
        },

        -- Diagnostics
        lualine_c = {
            {
                "diagnostics",
                sections = { "error", "warn", "info", "hint" },
                symbols = {
                    error = assets.lsp.error,
                    warn = assets.lsp.warning,
                    info = assets.lsp.info,
                    hint = assets.lsp.hint,
                },
                colored = true,
                update_in_insert = false,
                always_visible = false,
                padding = 1,
            },
            {
                function()
                    local Lsp = vim.lsp.util.get_progress_messages()[1]
                    if Lsp then
                        local msg = Lsp.message or ""
                        local percentage = Lsp.percentage or 0
                        local title = Lsp.title or ""
                        local spinners = {
                            "",
                            "",
                            "",
                        }
                        local success_icon = {
                            "",
                            "",
                            "",
                        }
                        local ms = vim.loop.hrtime() / 1000000
                        local frame = math.floor(ms / 120) % #spinners
                        if percentage >= 70 then
                            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg,
                                percentage)
                        end

                        return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
                    end

                    return ""
                end,
                padding = 0,
                color = {
                    gui = "bold",
                },
            }
        },

        -- Copilot
        lualine_x = {
            {
                function()
                    local copilot = require("copilot.api").status.data
                    if copilot ~= nil then
                        return assets.copilot .. ""
                    end
                end,
                padding = {
                    left = 1,
                    right = 1,
                },
                color = function()
                    local copilot_colors = {
                        [""] = Util.fg("@text.math"),
                        ["Normal"] = Util.fg("@text.math"),
                        ["Warning"] = Util.fg("@comment.todo"),
                        ["InProgress"] = Util.fg("@comment.warning"),
                    }
                    local copilot = require("copilot.api").status.data
                    if copilot ~= nil then
                        return copilot_colors[copilot.status]
                    end
                end,
            },
        },

        -- LSP provider
        lualine_y = {
            {
                function()
                    if next(vim.lsp.get_active_clients()) ~= nil then
                        return assets.lsp.server .. "LSP"
                    else
                        return ""
                    end
                end,
                padding = {
                    left = 1,
                    right = 1,
                },
                color = {
                    gui = "bold",
                },
            },
        },

        -- Location, file, and workspace
        lualine_z = {
            {
                function()
                    local current_line = vim.fn.line(".")
                    local total_line = vim.fn.line("$")

                    if current_line == 1 then
                        return "Top"
                    elseif current_line == vim.fn.line("$") then
                        return "Bottom"
                    end
                    local result, _ = math.modf((current_line / total_line) * 100)
                    return "" .. result .. "%%"
                end,
                padding = 1,
                color = {
                    gui = "bold",
                },
            },
            {
                function()
                    local row = vim.fn.line(".")
                    local column = vim.fn.col(".")
                    return "" .. row .. ":" .. column .. ""
                end,
                padding = {
                    left = 0,
                    right = 1,
                },
                color = {
                    gui = "bold",
                },
            },
            {
                function()
                    local filename = vim.fn.expand("%:t")
                    local extension = vim.fn.expand("%:e")
                    local icon = require("nvim-web-devicons").get_icon(filename, extension)
                    if icon == nil then
                        return "" .. assets.file .. ""
                    else
                        return (assets.show_modified and "%m" or "") .. "" .. icon .. " " .. filename .. ""
                    end
                end,
                padding = 1,
                color = {
                    gui = "bold",
                },
            },
            {
                function()
                    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                    return assets.dir .. dir_name
                end,
                padding = 1,
                color = {
                    gui = "bold",
                },
            },
        },
    },

    -- Inactive sections
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
}

function Plugin.init()
    vim.opt.showmode = false
end

return Plugin

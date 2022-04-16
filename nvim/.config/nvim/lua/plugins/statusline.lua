local colors = require("themes.catppuccin")
local lsp = require("feline.providers.lsp")
local lsp_severity = vim.diagnostic.severity

local icon_styles = {
    default = {
        left = "",
        right = " ",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
    },
    arrow = {
        left = "",
        right = "",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
    },

    block = {
        left = " ",
        right = " ",
        main_icon = "  ",
        vi_mode_icon = "  ",
        position_icon = "  ",
    },

    round = {
        left = "",
        right = "",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
    },

    slant = {
        left = "",
        right = " ",
        main_icon = "  ",
        vi_mode_icon = " ",
        position_icon = " ",
    },
}

local user_statusline_style = "block"
local statusline_style = icon_styles[user_statusline_style]

-- Initialize the components table
local components = {
    active = {},
    inactive = {},
}

-- Initialize left, mid and right
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})
table.insert(components.inactive, {})

components.active[1][1] = {
    provider = statusline_style.main_icon,

    hl = {
        fg = colors.black1,
        bg = colors.blue,
    },

    right_sep = {
        str = statusline_style.right,
        hl = {
            fg = colors.blue,
            bg = colors.black3,
        },
    },
}

components.active[1][2] = {
    provider = function()
        local filename = vim.fn.expand("%:t")
        local extension = vim.fn.expand("%:e")
        local icon = require("nvim-web-devicons").get_icon(filename, extension)
        if icon == nil then
            icon = " "
            return icon
        end
        return " " .. icon .. " " .. filename .. "  "
    end,
    hl = {
        fg = colors.white,
        bg = colors.black3,
    },

    right_sep = {
        str = statusline_style.right,
        hl = { fg = colors.black1, bg = colors.black1 },
    },
}

components.active[1][3] = {
    provider = function()
        local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        return "  " .. dir_name .. "  "
    end,

    hl = {
        fg = colors.white,
        bg = colors.black1,
    },

    right_sep = {
        str = statusline_style.right,
        hl = {
            fg = colors.black1,
            bg = colors.black1,
        },
    },
}

components.active[1][4] = {
    provider = "git_diff_added",
    hl = {
        fg = colors.black1,
        bg = colors.black1,
    },
    icon = " ",
}
-- diffModfified
components.active[1][5] = {
    provider = "git_diff_changed",
    hl = {
        fg = colors.black1,
        bg = colors.black1,
    },
    icon = "   ",
}
-- diffRemove
components.active[1][6] = {
    provider = "git_diff_removed",
    hl = {
        fg = colors.black1,
        bg = colors.black1,
    },
    icon = "  ",
}

components.active[1][7] = {
    provider = "diagnostic_errors",
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.ERROR)
    end,

    hl = { fg = colors.red, bg = colors.black1 },
    icon = "  ",
}

components.active[1][8] = {
    provider = "diagnostic_warnings",
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.WARN)
    end,
    hl = { fg = colors.yellow, bg = colors.black1 },
    icon = "  ",
}

components.active[1][9] = {
    provider = "diagnostic_hints",
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.HINT)
    end,
    hl = { fg = colors.grey0, bg = colors.black1 },
    icon = "  ",
}

components.active[1][10] = {
    provider = "diagnostic_info",
    enabled = function()
        return lsp.diagnostics_exist(lsp_severity.INFO)
    end,
    hl = { fg = colors.green },
    icon = "  ",
}

components.active[2][1] = {
    provider = function()
        local Lsp = vim.lsp.util.get_progress_messages()[1]
        if Lsp then
            local msg = Lsp.message or ""
            local percentage = Lsp.percentage or 0
            local title = Lsp.title or ""
            local spinners = {
                "",
                "",
                "",
            }

            local success_icon = {
                "",
                "",
                "",
            }

            local ms = vim.loop.hrtime() / 1000000
            local frame = math.floor(ms / 120) % #spinners

            if percentage >= 70 then
                return string.format(
                " %%<%s %s %s (%s%%%%) ",
                success_icon[frame + 1],
                title,
                msg,
                percentage
                )
            else
                return string.format(
                " %%<%s %s %s (%s%%%%) ",
                spinners[frame + 1],
                title,
                msg,
                percentage
                )
            end
        end
        return ""
    end,
    hl = { fg = colors.mauve, bg = colors.black1},
}

components.active[3][1] = {
    provider = function()
        if next(vim.lsp.buf_get_clients()) ~= nil then
            return " LSP"
        else
            return ""
        end
    end,
    hl = { fg = colors.grey0, bg = colors.black1 },

    right_sep = {
        str = statusline_style.right,
        hl = {
            fg = colors.black0,
            bg = colors.black1,
        },
    },
}

components.active[3][2] = {
    provider = "git_branch",
    hl = {
        fg = colors.white,
        bg = colors.black1,
    },
    icon = "  ",
}

components.active[3][3] = {
    provider = "" .. statusline_style.left,
    hl = {
        fg = colors.black1,
        bg = colors.black1,
    },
}

local mode_colors = {
    ["n"] = { "NORMAL", colors.blue },
    ["no"] = { "N-PENDING", colors.red },
    ["i"] = { "INSERT", colors.mauve },
    ["ic"] = { "INSERT", colors.mauve },
    ["t"] = { "TERMINAL", colors.red },
    ["v"] = { "VISUAL", colors.green },
    ["V"] = { "V-LINE", colors.green },
    [""] = { "V-BLOCK", colors.green },
    ["R"] = { "REPLACE", colors.orange },
    ["Rv"] = { "V-REPLACE", colors.orange },
    ["s"] = { "SELECT", colors.blue },
    ["S"] = { "S-LINE", colors.blue },
    [""] = { "S-BLOCK", colors.blue },
    ["c"] = { "COMMAND", colors.pink },
    ["cv"] = { "COMMAND", colors.pink },
    ["ce"] = { "COMMAND", colors.pink },
    ["r"] = { "PROMPT", colors.teal },
    ["rm"] = { "MORE", colors.teal },
    ["r?"] = { "CONFIRM", colors.teal },
    ["!"] = { "SHELL", colors.green },
}

local highlight_mode = function()
    return {
        fg = mode_colors[vim.fn.mode()][2],
        bg = colors.black1,
    }
end

components.active[3][4] = {
    provider = statusline_style.left,
    hl = function()
        return {
            fg = mode_colors[vim.fn.mode()][2],
            bg = colors.black1,
        }
    end,
}

components.active[3][5] = {
    provider = statusline_style.vi_mode_icon,
    hl = function()
        return {
            fg = colors.black1,
            bg = mode_colors[vim.fn.mode()][2],
        }
    end,
}

components.active[3][6] = {
    provider = function()
        return " " .. mode_colors[vim.fn.mode()][1] .. " "
    end,
    hl = highlight_mode,
}

components.active[3][7] = {
    -- provider = statusline_style.left,
    provider = "",
    hl = {
        fg = colors.black1,
        bg = colors.black1,
    },
}

components.active[3][8] = {
    -- provider = statusline_style.left,
    provider = "",
    hl = {
        fg = colors.green,
        bg = colors.black1,
    },
}

components.active[3][9] = {
    provider = statusline_style.position_icon,
    hl = {
        fg = colors.black1,
        bg = colors.green,
    },
}

components.active[3][10] = {
    provider = function()
        local current_line = vim.fn.line(".")
        local total_line = vim.fn.line("$")

        if current_line == 1 then
            return " Top "
        elseif current_line == vim.fn.line("$") then
            return " Bottom "
        end
        local result, _ = math.modf((current_line / total_line) * 100)
        return " " .. result .. "%% "
    end,

    hl = {
        fg = colors.green,
        bg = colors.black2,
    },
}

components.inactive = components.active

require("feline").setup({
    colors = {
        bg = colors.black1,
        fg = colors.black1,
    },

    components = components,
})

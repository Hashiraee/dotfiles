Plugin = { "nvim-lualine/lualine.nvim" }

Plugin.name = "lualine"

Plugin.event = "VeryLazy"

local C = require("catppuccin.palettes").get_palette()

local set = {
    text = C.surface0,
    bkg = C.surface0,
    diffs = C.mauve,
    extras = C.overlay1,
    curr_file = C.maroon,
    curr_dir = C.flamingo,
    lualine_bg = "#191828",
    show_modified = false,
}

if require("catppuccin").flavour == "latte" then
    local latte = require("catppuccin.palettes").get_palette("latte")
    set.text = latte.base
    set.bkg = latte.crust
end

local mode_colors = {
    ["n"] = { "NORMAL", C.lavender },
    ["no"] = { "N-PENDING", C.lavender },
    ["i"] = { "INSERT", C.green },
    ["ic"] = { "INSERT", C.green },
    ["t"] = { "TERMINAL", C.green },
    ["v"] = { "VISUAL", C.flamingo },
    ["V"] = { "V-LINE", C.flamingo },
    [""] = { "V-BLOCK", C.flamingo },
    ["R"] = { "REPLACE", C.maroon },
    ["Rv"] = { "V-REPLACE", C.maroon },
    ["s"] = { "SELECT", C.maroon },
    ["S"] = { "S-LINE", C.maroon },
    [""] = { "S-BLOCK", C.maroon },
    ["c"] = { "COMMAND", C.peach },
    ["cv"] = { "COMMAND", C.peach },
    ["ce"] = { "COMMAND", C.peach },
    ["r"] = { "PROMPT", C.teal },
    ["rm"] = { "MORE", C.teal },
    ["r?"] = { "CONFIRM", C.mauve },
    ["!"] = { "SHELL", C.green },
}

local assets = {
    left_separator = "",
    right_separator = "",
    bar = "█",
    mode_icon = "",
    dir = " ",
    file = " ",
    lsp = {
        server = "",
        error = " ",
        warning = " ",
        info = " ",
        hint = " ",
    },
    git = {
        branch = "",
        added = " ",
        changed = " ",
        removed = " ",
    },
}

Plugin.opts = {
    options = {
        theme = "auto",
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
            statusline = 500,
        }
    },
    sections = {
        lualine_a = {
            {
                "mode",
                padding = 1,
                color = function()
                    return {
                        fg = set.text,
                        bg = mode_colors[vim.fn.mode()][2],
                        gui = "bold",
                    }
                end,
            },
            {
                "diff",
                colored = false,
                symbols = { added = assets.git.added, modified = assets.git.changed, removed = assets.git.removed },
                color = function()
                    return {
                        fg = set.text,
                        bg = set.diffs,
                        -- bg = mode_colors[vim.fn.mode()][2],
                    }
                end,
            },
        },
        lualine_b = {
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
                    fg = set.extras,
                    bg = set.lualine_bg,
                },
            },
            {
                function()
                    local row = vim.fn.line(".")
                    local column = vim.fn.col(".")
                    return "" .. row .. ":" .. column .. ""
                end,
                padding = 1,
                color = {
                    fg = set.extras,
                    bg = set.lualine_bg,
                },
            },
        },
        lualine_c = {
            {
                function()
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
                            return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg,
                                percentage)
                        end

                        return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
                    end

                    return ""
                end,
                padding = 0,
                colors = {
                    bg = set.lualine_bg,
                }
            },
            {
                "diagnostics",
                sections = { "error", "warn", "info", "hint" },
                diagnostics_color = {
                    error = "DiagnosticError",
                    warn  = "DiagnosticWarn",
                    info  = "DiagnosticInfo",
                    hint  = "DiagnosticHint",
                },
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
                color = {
                    bg = set.lualine_bg,
                },
            },
        },
        lualine_x = {
            {
                function()
                    if next(vim.lsp.get_active_clients()) ~= nil then
                        return assets.lsp.server .. " Lsp"
                    else
                        return ""
                    end
                end,
                padding = 1,
                color = {
                    fg = set.extras,
                    bg = set.lualine_bg,
                },
                --[[ function()
                    if next(vim.lsp.get_active_clients()) ~= nil then
                        local clients = vim.lsp.get_active_clients()
                        local client_names = {}
                        for _, client in ipairs(clients) do
                            table.insert(client_names, client.name)
                        end
                        return assets.lsp.server .. "Lsp: " .. table.concat(client_names, ', ') .. " "
                    else
                        return ""
                    end
                end, ]]
            },
        },
        lualine_y = {
            {
                "branch",
                icon = assets.git.branch,
                padding = 1,
                color = {
                    fg = set.extras,
                    bg = set.lualine_bg,
                },
            },
        },
        lualine_z = {
            {
                function()
                    local filename = vim.fn.expand("%:t")
                    local extension = vim.fn.expand("%:e")
                    local icon = require("nvim-web-devicons").get_icon(filename, extension)
                    if icon == nil then
                        return "" .. assets.file .. ""
                    else
                        return (set.show_modified and "%m" or "") .. "" .. icon .. " " .. filename .. ""
                    end
                end,
                padding = 1,
                color = {
                    fd = set.text,
                    bg = set.curr_file,
                },
            },
            {
                function()
                    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                    return assets.dir .. dir_name
                end,
                padding = 2,
                color = {
                    fg = set.text,
                    bg = set.curr_dir,
                }
            },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {}
    },
}

function Plugin.init()
    vim.opt.showmode = false
end

return Plugin

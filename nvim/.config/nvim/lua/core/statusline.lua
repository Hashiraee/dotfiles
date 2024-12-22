local assets = {
    dir = " ",
    file = " ",
    lsp = {
        server = " ",
        error = " ",
        warning = " ",
        info = " ",
        hint = " ",
    },
    git = {
        branch = "󰘬 ",
        added = " ",
        changed = " ",
        removed = " ",
    },
    copilot = " ",
}


local palette = require("rose-pine.palette")
local colors = {
    normal = {
        section = { bg = palette.rose, fg = palette.base, gui = "bold" },
    },
    insert = {
        section = { bg = palette.foam, fg = palette.base, gui = "bold" },
    },
    visual = {
        section = { bg = palette.iris, fg = palette.base, gui = "bold" },
    },
    replace = {
        section = { bg = palette.pine, fg = palette.base, gui = "bold" },
    },
    command = {
        section = { bg = palette.love, fg = palette.base, gui = "bold" },
    },
    inactive = {
        section = { bg = palette.gold, fg = palette.base, gui = "bold" },
    },
}


local modes = {
    ["n"] = "NORMAL",
    ["no"] = "NORMAL",
    ["v"] = "VISUAL",
    ["V"] = "VISUAL-LINE",
    [""] = "VISUAL-BLOCK",
    ["s"] = "SELECT",
    ["S"] = "SELECT-LINE",
    [""] = "SELECT-BLOCK",
    ["i"] = "INSERT",
    ["ic"] = "INSERT",
    ["R"] = "REPLACE",
    ["Rv"] = "VISUAL-REPLACE",
    ["c"] = "COMMAND",
    ["cv"] = "VIM-EX",
    ["ce"] = "EX",
    ["r"] = "PROMPT",
    ["rm"] = "MOAR",
    ["r?"] = "CONFIRM",
    ["!"] = "SHELL",
    ["t"] = "TERMINAL",
}


local function set_mode_colors()
    -- Set custom colors for each mode
    vim.api.nvim_set_hl(0, "StatuslineAccent", { fg = colors.normal.section.fg, bg = colors.normal.section.bg })
    vim.api.nvim_set_hl(0, "StatuslineInsertAccent", { fg = colors.insert.section.fg, bg = colors.insert.section.bg })
    vim.api.nvim_set_hl(0, "StatuslineVisualAccent", { fg = colors.visual.section.fg, bg = colors.visual.section.bg })
    vim.api.nvim_set_hl(0, "StatuslineReplaceAccent", { fg = colors.replace.section.fg, bg = colors.replace.section.bg })
    vim.api.nvim_set_hl(0, "StatuslineCmdLineAccent", { fg = colors.command.section.fg, bg = colors.command.section.bg })
    vim.api.nvim_set_hl(0, "StatuslineTerminalAccent", { fg = colors.command.section.fg, bg = colors.command.section.bg })
    vim.api.nvim_set_hl(0, "StatuslineInactiveAccent", { fg = colors.inactive.section.fg, bg = colors.inactive.section.bg })
end


local function mode()
    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end


local function setup_lsp_highlights()
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color_bg = colors.normal.section.bg

    if current_mode == "i" or current_mode == "ic" then
        mode_color_bg = colors.insert.section.bg
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color_bg = colors.visual.section.bg
    elseif current_mode == "R" then
        mode_color_bg = colors.replace.section.bg
    elseif current_mode == "c" then
        mode_color_bg = colors.command.section.bg
    elseif current_mode == "t" then
        mode_color_bg = colors.command.section.bg
    end

    vim.api.nvim_set_hl(0, "LspDiagnosticsError", { fg = colors.command.section.bg, bg = mode_color_bg })
    vim.api.nvim_set_hl(0, "LspDiagnosticsWarning", { fg = colors.inactive.section.bg, bg = mode_color_bg })
    vim.api.nvim_set_hl(0, "LspDiagnosticsInfo", { fg = colors.insert.section.bg, bg = mode_color_bg })
    vim.api.nvim_set_hl(0, "LspDiagnosticsHint", { fg = colors.visual.section.bg, bg = mode_color_bg })
end


local function update_mode_colors()
    local current_mode = vim.api.nvim_get_mode().mode
    local mode_color = "%#StatuslineAccent#"

    if current_mode == "n" then
        mode_color = "%#StatuslineAccent#"
    elseif current_mode == "i" or current_mode == "ic" then
        mode_color = "%#StatuslineInsertAccent#"
    elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
        mode_color = "%#StatuslineVisualAccent#"
    elseif current_mode == "R" then
        mode_color = "%#StatuslineReplaceAccent#"
    elseif current_mode == "c" then
        mode_color = "%#StatuslineCmdLineAccent#"
    elseif current_mode == "t" then
        mode_color = "%#StatuslineTerminalAccent#"
    end

    -- Setup highlight for LSP symbols
    setup_lsp_highlights()
    return mode_color
end


local function git()
---@diagnostic disable-next-line: undefined-field
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then
        return ""
    end

    local added = git_info.added and (assets.git.added .. git_info.added .. " ") or ""
    local changed = git_info.changed and (assets.git.changed .. git_info.changed .. " ") or ""
    local removed = git_info.removed and (assets.git.removed .. git_info.removed .. " ") or ""

    if git_info.added == 0 then
        added = ""
    end
    if git_info.changed == 0 then
        changed = ""
    end
    if git_info.removed == 0 then
        removed = ""
    end

    return " " .. assets.git.branch .. git_info.head .. " " .. added .. changed .. removed
end


local function lsp_progress()
    -- local Lsp = vim.lsp.util.get_progress_messages()[1]
    local Lsp = vim.lsp.status()[1]
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
end


local function lsp()
    local count = {}
    local levels = {
        errors = "ERROR",
        warnings = "WARN",
        info = "INFO",
        hints = "HINT",
    }

    for k, level in pairs(levels) do
        count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
    end

    local errors = ""
    local warnings = ""
    local hints = ""
    local info = ""

    if count["errors"] ~= 0 then
        errors = "%#LspDiagnosticsError#" .. assets.lsp.error .. count["errors"] .. " "
    end
    if count["warnings"] ~= 0 then
        warnings = "%#LspDiagnosticsWarning#" .. assets.lsp.warning .. count["warnings"] .. " "
    end
    if count["hints"] ~= 0 then
        hints = "%#LspDiagnosticsHint#" .. assets.lsp.hint .. count["hints"] .. " "
    end
    if count["info"] ~= 0 then
        info = "%#LspDiagnosticsInfo#" .. assets.lsp.info .. count["info"] .. " "
    end

    if count["errors"] ~= 0 and count["warnings"] ~= 0 and count["hints"] ~= 0 and count["info"] ~= 0 then
        return ""
    end

    return "" .. errors .. warnings .. hints .. info
end


local function lsp_status()
    if next(vim.lsp.get_clients()) == nil then
        return ""
    end

    return " " .. assets.lsp.server .. "LSP "
end


local function file_position()
    local current_line = vim.fn.line(".")
    local total_line = vim.fn.line("$")

    if current_line == 1 then
        return " Top "
    elseif current_line == vim.fn.line("$") then
        return " Bottom "
    end

    local result, _ = math.modf((current_line / total_line) * 100)
    return " " .. result .. "%%" .. " "
end


local function line_info()
    local row = vim.fn.line(".")
    local column = vim.fn.col(".")
    return " " .. row .. ":" .. column .. " "
end


local function filetype()
    local file_name = vim.fn.expand("%:t")
    local extension = vim.fn.expand("%:e")
    local icon = require("nvim-web-devicons").get_icon(file_name, extension)

    if icon == nil then
        return " " .. assets.file .. " "
    else
        return (assets.show_modified and "%m" or " ") .. "" .. icon .. " " .. file_name .. " "
    end
end


local function directory()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return " " .. assets.dir .. dir_name .. " "
end


-- local function copilot()
--     local copilot_status = require("copilot.api").status.data
--
--     if copilot_status ~= nil then
--         return " " .. assets.copilot .. " "
--     end
-- end


Statusline = {}

---@diagnostic disable-next-line: duplicate-set-field
Statusline.active = function()
    set_mode_colors()
    return table.concat({
        "%#Statusline#",
        update_mode_colors(),
        mode(),
        git(),
        lsp_progress(),
        lsp(),
        update_mode_colors(),
        "%=%#StatusLineExtra#",
        update_mode_colors(),
        -- copilot(),
        lsp_status(),
        file_position(),
        line_info(),
        filetype(),
        directory(),
    })
end

---@diagnostic disable-next-line: duplicate-set-field
function Statusline.inactive()
    return table.concat({
        "%#StatuslineInactiveAccent#",
        " ",
        "%#StatuslineInactiveAccent#",
        "%f",
        "%=",
        directory(),
    })
end

local statusline_group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = statusline_group,
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.active()"
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = statusline_group,
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
    end,
})

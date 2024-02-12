local M = {}

function M.fg(name)
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
  local fg = hl and (hl.fg or hl.foreground)
  return fg and { fg = string.format("#%06x", fg) } or nil
end

function M.bg(name)
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name })
  local bg = hl and (hl.bg or hl.background)
  return bg and { bg = string.format("#%06x", bg) } or nil
end

return M

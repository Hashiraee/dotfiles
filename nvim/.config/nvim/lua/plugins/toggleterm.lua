local present, toggleterm = pcall(require, "toggleterm")
if not present then
    return
end

toggleterm.setup{
  size = function(term)
    if term.direction == "horizontal" then
      return vim.o.lines * 0.4
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- see :h nvim_open_win for details on borders however
    -- border = 'single' | 'double' | 'shadow'
    border = 'single',
    width = 100,
    height = 50,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  }
}

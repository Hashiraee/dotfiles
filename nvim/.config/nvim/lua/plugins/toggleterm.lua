local present, toggleterm = pcall(require, "toggleterm")
if not present then
    return
end

toggleterm.setup
{
  function(term)
    if term.direction == "horizontal" then
      return 25
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,

  open_mapping = '<C-\\>',
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,

  -- Direction of terminal, options: 'vertical' | 'horizontal' | 'tab' | 'float'.
  direction = 'horizontal',

  -- Terminal closes on exit, and default shell.
  close_on_exit = true,
  shell = vim.o.shell,

  -- Configuration for using float
  float_opts =
  {
    border = 'curved',

    -- Dimensions of floating window
    width = 100,
    height = 100,

    winblend = 3,

    -- Style of floating window
    highlights =
    {
      border = "Normal",
      background = "Normal",
    },
  }
}

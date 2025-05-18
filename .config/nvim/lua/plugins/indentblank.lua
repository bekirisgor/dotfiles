vim.opt.list = false

local indent_blankline = pcall(require, "indent_blankline")

indent_blankline.setup({
  char = "",
  show_current_context = false,
  show_current_context_start = false,
  -- strict_tab = false,
})

local ok, ibl = pcall(require, 'ibl')
if not ok then
  return
end

-- local hooks = require "ibl.hooks"
--[[ hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)

hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_tab_indent_level
) ]]

ibl.setup({
  indent = {
    char = "▎",
    tab_char = "▎",
  },
  scope = {
    show_start = false,
    highlight = { "Normal" },
  },
  -- space_char_blankline = " ",
  -- show_current_context = true,
  -- show_current_context_start = false,
  -- show_first_indent_level = false,
  -- show_trailing_blankline_indent = false,
  -- char = "▎",
  -- disable_with_nolist = true,
  -- max_indent_increase = 1,
  -- use_treesitter_scope = true,
})

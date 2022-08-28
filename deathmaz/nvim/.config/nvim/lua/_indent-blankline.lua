local ok, blankline = pcall(require, 'indent_blankline')
if not ok then
  return
end

blankline.setup({
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = false,
  show_first_indent_level = false,
  show_trailing_blankline_indent = false,
  char = "▎",
  disable_with_nolist = true,
  max_indent_increase = 1,
  -- use_treesitter_scope = true,
})

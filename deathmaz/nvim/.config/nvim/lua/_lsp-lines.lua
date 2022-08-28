local ok, lines = pcall(require, 'lsp_lines')
if not ok then
  return
end

lines.setup()
vim.keymap.set(
  "",
  "<Leader>l",
  require("lsp_lines").toggle,
  { desc = "Toggle lsp_lines" }
)

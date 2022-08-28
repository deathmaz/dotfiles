local colors = {}
local monokai_ok, monokai = pcall(require, 'monokai')
if monokai_ok then
  local palette = monokai.classic
  colors = {
    info = { palette.aqua },
    hint = { palette.green },
    default = { palette.purple },
    test = { palette.pink },
  }
end

require("todo-comments").setup {
  signs = false,
  colors = colors,
}

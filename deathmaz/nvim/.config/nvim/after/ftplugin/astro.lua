local format_class = require("_format-class")

format_class.setup({
  open = "class:list={[",
  close = "]}",
})

vim.keymap.set("n", "\\q", "<cmd>FormatClass<CR>", { silent = true, buffer = true })

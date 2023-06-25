vim.cmd [[
  command! -buffer FormatClass :s/class="\([^"]*\)"/\=printf(":class=\"[\n%s\n]\"", join(map(split(submatch(1)), "printf(\"'%s',\", v:val)"), "\n"))/
]]

vim.keymap.set("n", "\\q", '<cmd>FormatClass<CR>', {
  silent = true,
  buffer = true,
});

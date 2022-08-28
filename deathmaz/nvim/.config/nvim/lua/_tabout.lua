local ok, tabout = pcall(require, 'tabout')
if not ok then
  return
end

tabout.setup({
  completion = true,
  ignore_beginning = true,
})

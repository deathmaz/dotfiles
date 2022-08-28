local ok, template_string = pcall(require, 'template-string')
if not ok then
  return
end
template_string.setup({
  filetypes = {
    'vue',
    'typescript',
    'javascript',
    'typescriptreact',
    'javascriptreact',
  },
  remove_template_string = true,
})

local ok, treesitter_context = pcall(require, 'treesitter-context')
if not ok then
  return
end

treesitter_context.setup({
  multiline_threshold = 1,
  throttle = true,
})

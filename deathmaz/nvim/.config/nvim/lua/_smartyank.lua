local ok, smartyank = pcall(require, 'smartyank');
if not ok then
  return
end

smartyank.setup({
  highlight = {
    timeout = 250,
  }
})

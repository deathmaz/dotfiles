local ok, copilot = pcall(require, 'copilot')
if not ok then
  return
end

copilot.setup({
  suggestion = {
    enabled = true,
    auto_trigger = true,
  },
  panel = {
    enabled = false,
  },
  filetypes = {
    lua = true,
    php = true,
    javascript = true,
    vue = true,
    scss = true,
    typescript = true,
    markdown = true,
    ["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
  },
})

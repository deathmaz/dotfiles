local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then
  return
end

local provider = require('_provider')

autopairs.setup({
  check_ts = true,
  map_cr = false,
})

_G.MUtils = {}

if provider.is_coc() then
  MUtils.completion_confirm = function()
    if vim.fn["coc#pum#visible"]() ~= 0 then
      if vim.fn["coc#pum#info"]()["index"] == -1 then
        -- pum visible but nothing selected: dismiss and insert real CR
        vim.fn["coc#pum#cancel"]()
        return autopairs.autopairs_cr()
      else
        return vim.fn["coc#pum#confirm"]()
      end
    else
      return autopairs.autopairs_cr()
    end
  end

  vim.keymap.set("i", "<CR>", "v:lua.MUtils.completion_confirm()", { expr = true, noremap = true })
else
  MUtils.completion_confirm = function()
    return autopairs.autopairs_cr()
  end

  vim.keymap.set("i", "<CR>", "v:lua.MUtils.completion_confirm()", { expr = true, noremap = true })
end

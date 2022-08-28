local ok, gitsigns = pcall(require, 'gitsigns');
if not ok then
  return
end

local icons = require('_icons')
gitsigns.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = icons.box.LightVertical, numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = icons.box.LightVertical, numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = icons.box.HeavyHorizontal, numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
}

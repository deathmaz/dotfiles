-- vim.g.AutoPairsCompatibleMaps = 0
vim.g.AutoPairsMapBS = 1
vim.g.AutoPairsShortcutFastWrap = ""
vim.keymap.set('i', '<BS>', '<C-R>=AutoPairsDelete()<CR>', {
  buffer = true,
})

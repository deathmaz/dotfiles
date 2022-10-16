-- vim.g.AutoPairsCompatibleMaps = 0
vim.g.AutoPairsMapBS = 1
vim.keymap.set('i', '<BS>', '<C-R>=AutoPairsDelete()<CR>', {
  buffer = true,
})

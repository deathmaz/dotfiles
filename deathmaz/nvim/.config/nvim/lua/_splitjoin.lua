vim.g.splitjoin_split_mapping = ''
vim.g.splitjoin_join_mapping = ''

vim.keymap.set('n', 'sj', '<cmd>SplitjoinSplit<cr>', { noremap = true })
vim.keymap.set('n', 'sk', '<cmd>SplitjoinJoin<cr>', { noremap = true })

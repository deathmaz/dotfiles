local ok, tree = pcall(require, 'nvim-tree')
if not ok then
  return
end

local keymap = vim.keymap.set

tree.setup()

keymap('n', '<leader>df', '<cmd>NvimTreeFindFile<cr>')
keymap('n', '<leader>do', '<cmd>NvimTreeOpen<cr>')
keymap('n', '<leader>dc', '<cmd>NvimTreeClose<cr>')

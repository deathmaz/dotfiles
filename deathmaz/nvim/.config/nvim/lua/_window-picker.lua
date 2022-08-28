local ok, picker = pcall(require, 'window-picker')
if not ok then
  return
end

picker.setup({
  include_current_win = false,
})
local focus_window = function()
  local window = picker.pick_window()
  if window then
    vim.api.nvim_set_current_win(window)
  end
end

vim.keymap.set('n', '<leader><leader>w', focus_window)

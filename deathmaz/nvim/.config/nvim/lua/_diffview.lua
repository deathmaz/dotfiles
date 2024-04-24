local ok, diffview = pcall(require, 'diffview');
if not ok then
  return
end

local actions = require("diffview.actions")
diffview.setup({
  enhanced_diff_hl = true,
  keymaps = {
    file_panel = {
      ["f"]  = actions.focus_entry,
      ["gf"] = actions.goto_file_edit,
    },
    file_history_panel = {
      ["gf"] = actions.goto_file_edit,
    }
  },
  hooks = {
    diff_buf_read = function()
      vim.b['coc_enabled'] = 0
    end,
    view_leave = function()
      vim.b['coc_enabled'] = 1
    end
  }
})

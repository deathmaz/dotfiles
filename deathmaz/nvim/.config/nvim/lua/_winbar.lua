local M = {}

M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
  "fern",
  "fugitive",
  "DiffviewFiles",
  "prompt",
  "sagarename",
  "sagahover",
  "sagacodeaction",
  "plaintext",
  "sagasignature",
  "qf",
  "checkhealth",
  "lspinfo",
  "lspsagaoutline",
  "mason",
  "CommandTPrompt",
}

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

local icons = require('_icons')
function M.winbar()
  local api = vim.api
  local fn = vim.fn
  local win = api.nvim_tabpage_get_win(0)
  local buf = api.nvim_win_get_buf(win)
  local filename = fn.expand "%:t"
  local extension = fn.expand "%:e"
  local modified = api.nvim_buf_get_option(buf, 'modified')
  local icon, color = require 'nvim-web-devicons'.get_icon_color(filename, extension, { default = true })
  local hl_group = "FileIconColor" .. extension
  vim.api.nvim_set_hl(0, hl_group, { fg = color })
  local modified_str

  if modified then
    modified_str = icons.ui.Circle
  else
    modified_str = ''
  end

  if excludes() then
    return ""
  end

  -- Lsp saga
  --[[ local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
  local sym
  if ok then sym = lspsaga.get_symbol_node() end
  local win_val = ''
  if sym ~= nil then
    win_val = win_val .. sym
  end ]]

  local win_val = ''
  local status_ok, navic = pcall(require, "nvim-navic")
  if status_ok then
    win_val = navic.get_location()
  end

  local val = " " ..
      "%#" ..
      hl_group .. "#" .. icon .. "%*" .. " " .. "%#Normal#" .. filename .. "%*" .. " " .. modified_str .. " " .. win_val
  return val
  -- vim.wo.winbar = val
end

vim.o.winbar = "%{%v:lua.require'_winbar'.winbar()%}"
--[[ vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" }, {
  callback = function()
    M.winbar()
  end,
}) ]]

-- Lsp saga
--[[ vim.api.nvim_create_autocmd('User', {
  pattern = 'LspsagaUpdateSymbol',
  callback = function() M.winbar() end,
}) ]]

return M

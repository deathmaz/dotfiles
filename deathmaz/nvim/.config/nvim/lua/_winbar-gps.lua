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
  "fern"
}

local get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"
  local f = require "_functions"

  if not f.isempty(filename) then
    local file_icon, file_icon_color = require("nvim-web-devicons").get_icon_color(
      filename,
      extension,
      { default = true }
    )

    local hl_group = "FileIconColor" .. extension

    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.isempty(file_icon) then
      file_icon = ""
      file_icon_color = ""
    end

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Normal#" .. filename .. "%*"
  end
end

local icons = require('_icons')
local space = " ";
local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-gps")
  if not status_gps_ok then
    return ""
  end
  gps.setup({
    icons = {
      ["function-name"] = "%#TSFunction#" .. icons.kind.Function .. "%*" .. space, -- Functions
      ["class-name"] = "%#CmpItemKindClass#" .. icons.kind.Class .. "%*" .. space, -- Classes and class-like objects
      ["method-name"] = "%#CmpItemKindMethod#" .. icons.kind.Method .. "%*" .. space, -- Methods (functions inside class-like objects)
      ["container-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space, -- Containers (example: lua tables)
      ["tag-name"] = "%#CmpItemKindKeyword#" .. icons.misc.Tag .. "%*" .. " ", -- Tags (example: html tags)
      ["mapping-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space,
      ["sequence-name"] = "%#CmpItemKindProperty#" .. icons.type.Array .. "%*" .. space,
      ["null-name"] = "%#CmpItemKindField#" .. icons.kind.Field .. "%*" .. space,
      ["boolean-name"] = "%#CmpItemKindValue#" .. icons.type.Boolean .. "%*" .. space,
      ["integer-name"] = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
      ["float-name"] = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
      ["string-name"] = "%#CmpItemKindValue#" .. icons.type.String .. "%*" .. space,
      ["array-name"] = "%#CmpItemKindProperty#" .. icons.type.Array .. "%*" .. space,
      ["object-name"] = "%#CmpItemKindProperty#" .. icons.type.Object .. "%*" .. space,
      ["number-name"] = "%#CmpItemKindValue#" .. icons.type.Number .. "%*" .. space,
      ["table-name"] = "%#CmpItemKindProperty#" .. icons.ui.Table .. "%*" .. space,
      ["date-name"] = "%#CmpItemKindValue#" .. icons.ui.Calendar .. "%*" .. space,
      ["date-time-name"] = "%#CmpItemKindValue#" .. icons.ui.Table .. "%*" .. space,
      ["inline-table-name"] = "%#CmpItemKindProperty#" .. icons.ui.Calendar .. "%*" .. space,
      ["time-name"] = "%#CmpItemKindValue#" .. icons.misc.Watch .. "%*" .. space,
      ["module-name"] = "%#CmpItemKindModule#" .. icons.kind.Module .. "%*" .. space,
    },
  });

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not require("_functions").isempty(gps_location) then
    return icons.ui.ChevronRight .. " " .. gps_location
  else
    return ""
  end
end

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local f = require "_functions"
  local value = get_filename()

  if not f.isempty(value) and f.get_buf_option "mod" then
    local mod = "%#Normal#" .. icons.ui.Circle .. "%*"
    value = value .. " " .. mod
  end

  if not f.isempty(value) then
    local gps_value = get_gps()
    value = value .. " " .. gps_value
  end


  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" }, {
  callback = function()
    require("_winbar-gps").get_winbar()
  end,
})

-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--   callback = function()
--     vim.cmd [[
--       highlight clear WinBar
--     ]]
--   end,
-- })

return M

local M = {}

local parseInt = require('_functions').parseInt;

function M.appendLoremPicsumUrl()
  local width = parseInt(vim.fn.input("width: "))
  local height = parseInt(vim.fn.input("height: "))

  if width and height then
    local curl = require("plenary.curl")

    local res = curl.get("https://picsum.photos/" .. width .. "/" .. height, {})
    local url = res.headers[3]:sub(11)

    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local nline = line:sub(0, cursor[2] + 1) .. url .. line:sub(cursor[2] + 2)

    vim.api.nvim_set_current_line(nline)
    vim.api.nvim_win_set_cursor(0, { cursor[1], cursor[2] + url:len() })
  end
end

vim.cmd("command LoremPicsum silent lua require'_lorem-picsum'.appendLoremPicsumUrl()")

return M

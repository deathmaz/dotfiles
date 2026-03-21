local M = {}

local split_opts = { trimempty = true }

--- Find a standalone class="..." attribute, skipping compound names
--- like enter-active-class, leave-class, etc.
local function find_standalone_class(line)
  local pos = 1
  while true do
    local s, e, classes = line:find('class="([^"]*)"', pos)
    if not s then return nil end
    if s == 1 or not line:sub(s - 1, s - 1):match("[%w-]") then
      return line:sub(1, s - 1), classes, line:sub(e + 1)
    end
    pos = e + 1
  end
end

--- Create a format_class function for a given output format.
--- @param opts { open: string, close: string }
---   open  — attribute prefix + opening bracket (e.g. ':class="[')
---   close — closing bracket + suffix           (e.g. ']"')
function M.create(opts)
  return function()
    local line = vim.api.nvim_get_current_line()
    local lnum = vim.fn.line(".")

    local before, classes, after = find_standalone_class(line)
    if not classes then
      vim.notify('No standalone class="..." found on current line', vim.log.levels.WARN)
      return
    end

    local parts = vim.split(classes, "%s+", split_opts)
    if #parts == 0 then return end

    local base_indent = line:match("^(%s*)")
    local item_indent = base_indent .. "  "

    local result = { before .. opts.open }
    for _, cls in ipairs(parts) do
      result[#result + 1] = item_indent .. "'" .. cls .. "',"
    end
    result[#result + 1] = base_indent .. opts.close .. after

    vim.api.nvim_buf_set_lines(0, lnum - 1, lnum, false, result)
  end
end

--- Register the FormatClass command for the current buffer.
--- @param opts { open: string, close: string }
function M.setup(opts)
  local fn = M.create(opts)
  vim.api.nvim_buf_create_user_command(0, "FormatClass", fn, {})
end

return M

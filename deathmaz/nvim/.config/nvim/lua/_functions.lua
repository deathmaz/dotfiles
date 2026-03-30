local M = {}

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

-- get length of current word
function M.get_word_length()
  local word = vim.fn.expand "<cword>"
  return #word
end

function M.toggle_option(option)
  local value = not vim.api.nvim_get_option_value(option, {})
  vim.opt[option] = value
  vim.notify(option .. " set to " .. tostring(value))
end

function M.toggle_tabline()
  local value = vim.api.nvim_get_option_value("showtabline", {})

  if value == 2 then
    value = 0
  else
    value = 2
  end

  vim.opt.showtabline = value

  vim.notify("showtabline" .. " set to " .. tostring(value))
end

local diagnostics_active = true
function M.toggle_diagnostics()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

function M.isempty(s)
  return s == nil or s == ""
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_get_option_value, opt, { buf = 0 })
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.find_git_root()
  local cmd_output = vim.fn.systemlist('git rev-parse --show-toplevel')

  if vim.v.shell_error == 0 and #cmd_output > 0 then
    return cmd_output[1]
  else
    return nil
  end
end

function M.parseInt(str)
  return str:match("^%-?%d+$")
end

function M.sort_checklist(line1, line2)
  local lines = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)

  local function is_checklist(item) return item.type == 'checked' or item.type == 'unchecked' end

  -- Parse lines into logical items. A checklist item may span multiple lines
  -- (continuation lines that aren't blank, headers, or new list items).
  local items = {}
  for _, line in ipairs(lines) do
    if line:match('^%s*-%s+%[[xX]%]') then
      table.insert(items, { lines = { line }, type = 'checked' })
    elseif line:match('^%s*-%s+%[ %]') then
      table.insert(items, { lines = { line }, type = 'unchecked' })
    elseif #items > 0
        and is_checklist(items[#items])
        and line ~= ''
        and not line:match('^#')
        and not line:match('^%s*%-') then
      table.insert(items[#items].lines, line)
    else
      table.insert(items, { lines = { line }, type = 'other' })
    end
  end

  local function flush(result, item_list)
    for _, item in ipairs(item_list) do
      vim.list_extend(result, item.lines)
    end
  end

  -- Sort each contiguous group of checklist items in place.
  -- Blank lines between checklist items are dropped since reordering
  -- makes their original positions meaningless.
  local result = {}
  local i = 1
  while i <= #items do
    if items[i].type == 'other' then
      vim.list_extend(result, items[i].lines)
      i = i + 1
    else
      local group = {}
      local j = i
      while j <= #items do
        if is_checklist(items[j]) then
          table.insert(group, items[j])
          j = j + 1
        elseif items[j].type == 'other'
            and #items[j].lines == 1 and items[j].lines[1] == '' then
          local k = j + 1
          while k <= #items
              and items[k].type == 'other'
              and #items[k].lines == 1 and items[k].lines[1] == '' do
            k = k + 1
          end
          if k <= #items and is_checklist(items[k]) then
            j = k
          else
            break
          end
        else
          break
        end
      end

      local unchecked = {}
      local checked = {}
      for _, item in ipairs(group) do
        if item.type == 'unchecked' then
          table.insert(unchecked, item)
        else
          table.insert(checked, item)
        end
      end
      flush(result, unchecked)
      flush(result, checked)

      i = j
    end
  end

  vim.api.nvim_buf_set_lines(0, line1 - 1, line2, false, result)
end

return M

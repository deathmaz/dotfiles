-- coc.nvim integration with fzf-lua
-- Provides fzf-lua pickers for coc.nvim features

local M = {}

-- Check dependencies
local fzf_ok, fzf_lua = pcall(require, 'fzf-lua')
if not fzf_ok then
  vim.notify('fzf-lua not available', vim.log.levels.ERROR)
  return M
end

local icons_ok, icons = pcall(require, '_icons')
if not icons_ok then
  vim.notify('_icons module not available', vim.log.levels.WARN)
  icons = { kind = {}, diagnostics = {}, vscode = {} }
end

local fn = vim.fn
local api = vim.api

-- ============================================================================
-- Helper Functions
-- ============================================================================

-- Check if coc.nvim is available and initialized
local function check_coc_available()
  if fn.exists('*CocActionAsync') == 0 then
    vim.notify('coc.nvim not available', vim.log.levels.ERROR)
    return false
  end

  if vim.g.coc_service_initialized ~= 1 then
    vim.notify('coc.nvim not initialized yet', vim.log.levels.WARN)
    return false
  end

  return true
end

-- Map LSP SymbolKind (both number and string) to icon
local symbol_kind_map = {
  -- Numbers (LSP spec)
  [1] = { icon = icons.kind.File or '', name = 'File' },
  [2] = { icon = icons.kind.Module or '', name = 'Module' },
  [3] = { icon = icons.kind.Namespace or '', name = 'Namespace' },
  [4] = { icon = icons.kind.Package or '', name = 'Package' },
  [5] = { icon = icons.kind.Class or '', name = 'Class' },
  [6] = { icon = icons.kind.Method or '', name = 'Method' },
  [7] = { icon = icons.kind.Property or '', name = 'Property' },
  [8] = { icon = icons.kind.Field or '', name = 'Field' },
  [9] = { icon = icons.kind.Constructor or '', name = 'Constructor' },
  [10] = { icon = icons.kind.Enum or '', name = 'Enum' },
  [11] = { icon = icons.kind.Interface or '', name = 'Interface' },
  [12] = { icon = icons.kind.Function or '', name = 'Function' },
  [13] = { icon = icons.kind.Variable or '', name = 'Variable' },
  [14] = { icon = icons.kind.Constant or '', name = 'Constant' },
  [15] = { icon = icons.kind.String or '', name = 'String' },
  [16] = { icon = icons.kind.Number or '', name = 'Number' },
  [17] = { icon = icons.kind.Boolean or '', name = 'Boolean' },
  [18] = { icon = icons.kind.Array or '', name = 'Array' },
  [19] = { icon = icons.kind.Object or '', name = 'Object' },
  [20] = { icon = icons.kind.Key or '', name = 'Key' },
  [21] = { icon = icons.kind.Null or '', name = 'Null' },
  [22] = { icon = icons.kind.EnumMember or '', name = 'EnumMember' },
  [23] = { icon = icons.kind.Struct or '', name = 'Struct' },
  [24] = { icon = icons.kind.Event or '', name = 'Event' },
  [25] = { icon = icons.kind.Operator or '', name = 'Operator' },
  [26] = { icon = icons.kind.TypeParameter or '', name = 'TypeParameter' },
  -- Strings (coc.nvim format)
  ['File'] = { icon = icons.kind.File or '', name = 'File' },
  ['Module'] = { icon = icons.kind.Module or '', name = 'Module' },
  ['Namespace'] = { icon = icons.kind.Namespace or '', name = 'Namespace' },
  ['Package'] = { icon = icons.kind.Package or '', name = 'Package' },
  ['Class'] = { icon = icons.kind.Class or '', name = 'Class' },
  ['Method'] = { icon = icons.kind.Method or '', name = 'Method' },
  ['Property'] = { icon = icons.kind.Property or '', name = 'Property' },
  ['Field'] = { icon = icons.kind.Field or '', name = 'Field' },
  ['Constructor'] = { icon = icons.kind.Constructor or '', name = 'Constructor' },
  ['Enum'] = { icon = icons.kind.Enum or '', name = 'Enum' },
  ['Interface'] = { icon = icons.kind.Interface or '', name = 'Interface' },
  ['Function'] = { icon = icons.kind.Function or '', name = 'Function' },
  ['Variable'] = { icon = icons.kind.Variable or '', name = 'Variable' },
  ['Constant'] = { icon = icons.kind.Constant or '', name = 'Constant' },
  ['String'] = { icon = icons.kind.String or '', name = 'String' },
  ['Number'] = { icon = icons.kind.Number or '', name = 'Number' },
  ['Boolean'] = { icon = icons.kind.Boolean or '', name = 'Boolean' },
  ['Array'] = { icon = icons.kind.Array or '', name = 'Array' },
  ['Object'] = { icon = icons.kind.Object or '', name = 'Object' },
  ['Key'] = { icon = icons.kind.Key or '', name = 'Key' },
  ['Null'] = { icon = icons.kind.Null or '', name = 'Null' },
  ['EnumMember'] = { icon = icons.kind.EnumMember or '', name = 'EnumMember' },
  ['Struct'] = { icon = icons.kind.Struct or '', name = 'Struct' },
  ['Event'] = { icon = icons.kind.Event or '', name = 'Event' },
  ['Operator'] = { icon = icons.kind.Operator or '', name = 'Operator' },
  ['TypeParameter'] = { icon = icons.kind.TypeParameter or '', name = 'TypeParameter' },
}

local function symbol_kind_to_icon(kind)
  -- If kind is nil or not found, return empty string for kind name to hide it
  if not kind or not symbol_kind_map[kind] then
    return '', ''
  end
  local info = symbol_kind_map[kind]
  return info.icon, info.name
end

-- Map diagnostic severity to icon
local severity_map = {
  [1] = { icon = icons.diagnostics.Error or '', name = 'Error', color = 'red' },
  [2] = { icon = icons.diagnostics.Warning or '', name = 'Warning', color = 'yellow' },
  [3] = { icon = icons.diagnostics.Information or '', name = 'Info', color = 'blue' },
  [4] = { icon = icons.diagnostics.Hint or '', name = 'Hint', color = 'grey' },
}

local function severity_to_icon(severity)
  local info = severity_map[severity] or { icon = '', name = 'Unknown', color = 'white' }
  return info.icon, info.name, info.color
end

-- ============================================================================
-- Document Symbols (Outline)
-- ============================================================================

function M.document_symbols()
  if not check_coc_available() then
    return
  end

  local bufnr = api.nvim_get_current_buf()
  local filepath = api.nvim_buf_get_name(bufnr)

  if filepath == '' then
    vim.notify('No file in current buffer', vim.log.levels.WARN)
    return
  end

  fn.CocActionAsync('documentSymbols', function(err, symbols)
    if err ~= vim.NIL then
      vim.notify('Error getting document symbols: ' .. vim.inspect(err), vim.log.levels.ERROR)
      return
    end

    if not symbols or #symbols == 0 then
      vim.notify('No symbols found in document', vim.log.levels.INFO)
      return
    end

    vim.schedule(function()
      local color = fzf_lua.utils.ansi_codes

      -- Store symbol metadata in a table for lookup
      local symbol_data = {}

      fzf_lua.fzf_exec(function(cb)
        for i, symbol in ipairs(symbols) do
          local icon, kind_name = symbol_kind_to_icon(symbol.kind)
          local line = symbol.selectionRange and symbol.selectionRange.start.line or symbol.range.start.line
          local col = symbol.selectionRange and symbol.selectionRange.start.character or symbol.range.start.character

          -- Get symbol name, handle missing name
          local symbol_name = symbol.name or symbol.text or 'Unnamed'

          -- Store metadata indexed by display string
          symbol_data[i] = {
            line = line + 1,
            col = col + 1,
            name = symbol_name,
          }

          -- Format: [idx] [icon] symbol_name (kind_name) :line
          -- Add colors for better visual distinction
          local entry
          if kind_name ~= '' then
            entry = string.format('[%d] %s %s %s %s',
              i,
              color.blue(icon),
              color.white(symbol_name),
              color.yellow('[' .. kind_name .. ']'),
              color.green(':' .. (line + 1))
            )
          else
            entry = string.format('[%d] %s %s %s',
              i,
              color.blue(icon),
              color.white(symbol_name),
              color.green(':' .. (line + 1))
            )
          end

          cb(entry)
        end
        cb()
      end, {
        prompt = 'Symbols> ',
        previewer = 'builtin',
        fn_preprocess = function(entry)
          -- Ensure entry is a string
          if type(entry) ~= 'string' then
            return tostring(entry)
          end

          -- Extract index from entry
          local idx = entry:match('%[(%d+)%]')
          if not idx then return entry end

          local data = symbol_data[tonumber(idx)]
          if not data then return entry end

          return filepath .. ':' .. data.line
        end,
        actions = {
          ['default'] = function(selected)
            if not selected or #selected == 0 then return end

            -- Extract index from selected entry
            local idx = selected[1]:match('%[(%d+)%]')
            if not idx then return end

            local data = symbol_data[tonumber(idx)]
            if not data then return end

            api.nvim_win_set_cursor(0, { data.line, data.col })
            vim.cmd('normal! zz')
          end,
        },
        winopts = {
          height = 0.85,
          width = 0.80,
        },
      })
    end)
  end)
end

-- ============================================================================
-- Diagnostics
-- ============================================================================

function M.diagnostics()
  if not check_coc_available() then
    return
  end

  fn.CocActionAsync('diagnosticList', '', function(err, diagnostics)
    if err ~= vim.NIL then
      vim.notify('Error getting diagnostics: ' .. vim.inspect(err), vim.log.levels.ERROR)
      return
    end

    if not diagnostics or #diagnostics == 0 then
      vim.notify('No diagnostics found', vim.log.levels.INFO)
      return
    end

    vim.schedule(function()
      local color = fzf_lua.utils.ansi_codes

      -- Sort by severity (Error > Warning > Info > Hint), then file, then line
      table.sort(diagnostics, function(a, b)
        if a.severity ~= b.severity then
          return a.severity < b.severity
        end
        if a.file ~= b.file then
          return a.file < b.file
        end
        return a.lnum < b.lnum
      end)

      -- Store diagnostic metadata in a table for lookup
      local diag_data = {}

      fzf_lua.fzf_exec(function(cb)
        for i, diag in ipairs(diagnostics) do
          local icon, severity_name, severity_color = severity_to_icon(diag.severity)

          -- Store metadata indexed by entry
          diag_data[i] = {
            file = diag.file,
            line = diag.lnum,
            col = diag.col,
          }

          -- Get relative path
          local relative_path = fn.fnamemodify(diag.file, ':.')

          -- Format message (first line only)
          local message = diag.message:match('([^\n]+)')

          -- Format source and code
          local source_info = ''
          if diag.source and diag.source ~= '' then
            source_info = diag.source
            if diag.code and diag.code ~= vim.NIL then
              source_info = source_info .. ' ' .. diag.code
            end
            source_info = '[' .. source_info .. ']'
          end

          -- Color icon based on severity
          local colored_icon = icon
          if severity_color == 'red' then
            colored_icon = color.red(icon)
          elseif severity_color == 'yellow' then
            colored_icon = color.yellow(icon)
          elseif severity_color == 'blue' then
            colored_icon = color.blue(icon)
          else
            colored_icon = color.grey(icon)
          end

          -- Format: [idx] [icon] file:line:col  message [source code]
          local entry = string.format('[%d] %s %s%s  %s %s',
            i,
            colored_icon,
            color.cyan(relative_path),
            color.green(':' .. diag.lnum .. ':' .. diag.col),
            message,
            color.grey(source_info)
          )

          cb(entry)
        end
        cb()
      end, {
        prompt = 'Diagnostics> ',
        previewer = 'builtin',
        fn_preprocess = function(entry)
          -- Ensure entry is a string
          if type(entry) ~= 'string' then
            return tostring(entry)
          end

          -- Extract index from entry
          local idx = entry:match('^%[(%d+)%]')
          if not idx then return entry end

          local data = diag_data[tonumber(idx)]
          if not data then return entry end

          -- Return absolute path for preview
          local abs_path = fn.fnamemodify(data.file, ':p')
          return abs_path .. ':' .. data.line
        end,
        actions = {
          ['default'] = function(selected)
            if not selected or #selected == 0 then return end

            -- Extract index from selected entry
            local idx = selected[1]:match('%[(%d+)%]')
            if not idx then return end

            local data = diag_data[tonumber(idx)]
            if not data then return end

            -- Open file and jump to location
            vim.cmd('edit ' .. fn.fnameescape(data.file))
            api.nvim_win_set_cursor(0, { data.line, data.col - 1 })
            vim.cmd('normal! zz')
          end,
        },
        winopts = {
          height = 0.85,
          width = 0.90,
        },
      })
    end)
  end)
end

-- ============================================================================
-- Commands
-- ============================================================================

function M.commands()
  if not check_coc_available() then
    return
  end

  fn.CocActionAsync('commands', function(err, commands)
    if err ~= vim.NIL then
      vim.notify('Error getting commands: ' .. vim.inspect(err), vim.log.levels.ERROR)
      return
    end

    if not commands or #commands == 0 then
      vim.notify('No commands available', vim.log.levels.INFO)
      return
    end

    vim.schedule(function()
      -- Sort commands alphabetically
      table.sort(commands, function(a, b)
        return a.title < b.title
      end)

      -- Store command metadata in a table for lookup
      local cmd_data = {}

      fzf_lua.fzf_exec(function(cb)
        for i, cmd in ipairs(commands) do
          -- Store command id indexed by entry
          cmd_data[i] = cmd.id

          -- Format: [idx] title
          cb(string.format('[%d] %s', i, cmd.title))
        end
        cb()
      end, {
        prompt = 'Commands> ',
        actions = {
          ['default'] = function(selected)
            if not selected or #selected == 0 then return end

            -- Extract index from selected entry
            local idx = selected[1]:match('%[(%d+)%]')
            if not idx then return end

            local cmd_id = cmd_data[tonumber(idx)]
            if not cmd_id then return end

            -- Execute command
            fn.CocActionAsync('runCommand', cmd_id, function(cmd_err, result)
              if cmd_err ~= vim.NIL then
                vim.notify('Error executing command: ' .. vim.inspect(cmd_err), vim.log.levels.ERROR)
              elseif result then
                vim.notify('Command executed successfully', vim.log.levels.INFO)
              end
            end)
          end,
        },
        winopts = {
          height = 0.70,
          width = 0.70,
        },
      })
    end)
  end)
end

-- ============================================================================
-- References
-- ============================================================================

function M.references()
  if not check_coc_available() then
    return
  end

  -- Get word under cursor for context
  local word = fn.expand('<cword>')

  -- Use 'references' instead of 'jumpReferences' to avoid opening quickfix
  fn.CocActionAsync('references', function(err, locations)
    if err ~= vim.NIL then
      vim.notify('Error getting references: ' .. vim.inspect(err), vim.log.levels.ERROR)
      return
    end

    if not locations or #locations == 0 then
      vim.notify('No references found for "' .. word .. '"', vim.log.levels.INFO)
      return
    end

    vim.schedule(function()
      local color = fzf_lua.utils.ansi_codes

      fzf_lua.fzf_exec(function(cb)
        for i, loc in ipairs(locations) do
          -- Get file path
          local file = loc.uri or loc.filename
          if file then
            -- Convert URI to path if needed
            file = file:gsub('^file://', '')
            file = fn.fnamemodify(file, ':.')
          end

          local line = loc.range and loc.range.start.line or loc.lnum or 0
          local col = loc.range and loc.range.start.character or loc.col or 0

          -- Try to get the line text for context
          local line_text = ''
          if file then
            local full_path = fn.fnamemodify(file, ':p')
            local lines = fn.readfile(full_path, '', line + 1)
            if lines and #lines > 0 then
              line_text = lines[#lines]:gsub('^%s+', ''):gsub('%s+$', '')
            end
          end

          -- Format: file:line:col  context_line
          -- Put file:line:col first so default previewer can parse it
          local entry = string.format('%s:%d:%d  %s',
            file,
            line + 1,
            col + 1,
            color.grey(line_text)
          )

          cb(entry)
        end
        cb()
      end, {
        prompt = 'References (' .. word .. ')> ',
        previewer = 'builtin',
        fzf_opts = {
          ['--ansi'] = '',
        },
        actions = {
          ['default'] = function(selected)
            if not selected or #selected == 0 then return end

            -- Parse file:line:col from entry
            local entry = selected[1]
            local filepath, line_num, col_num = entry:match('^([^:]+):(%d+):(%d+)')

            if not filepath then return end

            -- Open file and jump to location
            vim.cmd('edit ' .. fn.fnameescape(filepath))
            api.nvim_win_set_cursor(0, { tonumber(line_num), tonumber(col_num) - 1 })
            vim.cmd('normal! zz')
          end,
        },
        winopts = {
          height = 0.85,
          width = 0.95,
        },
      })
    end)
  end)
end

-- ============================================================================
-- Module Exports
-- ============================================================================

return M

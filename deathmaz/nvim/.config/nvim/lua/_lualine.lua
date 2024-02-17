local ok, lualine = pcall(require, 'lualine')
if not ok then
  return
end

local icons = require('_icons')
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end
local mode_map = {
  ['NORMAL'] = 'N',
  ['O-PENDING'] = 'N?',
  ['INSERT'] = 'I',
  ['VISUAL'] = 'V',
  ['V-BLOCK'] = 'VB',
  ['V-LINE'] = 'VL',
  ['V-REPLACE'] = 'VR',
  ['REPLACE'] = 'R',
  ['COMMAND'] = '!',
  ['SHELL'] = 'SH',
  ['TERMINAL'] = 'T',
  ['EX'] = 'X',
  ['S-BLOCK'] = 'SB',
  ['S-LINE'] = 'SL',
  ['SELECT'] = 'S',
  ['CONFIRM'] = 'Y?',
  ['MORE'] = 'M',
}
lualine.setup {
  options = {
    theme = "catppuccin",
    section_separators = '',
    component_separators = '',
  },
  sections = {
    lualine_a = {
      {
        'mode',
        fmt = function(s)
          return mode_map[s] or s
        end,
      },
    },
    lualine_b = {
      {
        'b:gitsigns_head',
        icon = icons.vscode.GitBranch,
      },
      {
        'diff',
        source = diff_source,
        symbols = {
          added = icons.vscode.DiffAdded .. ' ',
          modified = icons.vscode.DiffModified .. ' ',
          removed = icons.vscode.DiffRemoved .. ' ',
        }
      },
      {
        'diagnostics',
        symbols = {
          error = icons.vscode.Error .. ' ',
          warn = icons.vscode.Warning .. ' ',
          info = icons.vscode.Lightbulb .. ' ',
          hint = icons.vscode.Info .. ' ',
        },
      },
    },
    lualine_c = {
      {
        'filename',
        symbols = {
          modified = icons.vscode.Edit,
          readonly = icons.vscode.LockSmall,
          unnamed = '[No Name]',
          newfile = icons.vscode.NewFile,
        }
      },
    },
    lualine_x = {
      'g:coc_status',
      'filetype',
    },
  },
  extensions = {
    'fugitive'
  }
}

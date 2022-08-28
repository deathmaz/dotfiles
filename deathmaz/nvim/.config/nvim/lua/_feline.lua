local ok, feline = pcall(require, 'feline')
if not ok then
  return
end

local lsp = require('feline.providers.lsp')

-- local lazy_require = require('feline.utils').lazy_require
-- local gps = require("nvim-gps")
-- gps.setup()

local components = {
  active = {},
  inactive = {}
}

-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})

local section_bg_color = 'bg'
local monokai_ok, monokai = pcall(require, 'monokai')
if monokai_ok then
  local palette = monokai.classic
  section_bg_color = palette.base4
end

local left_sep = {
  {
    str = ' ',
    hl = {
      fg = 'fg',
      bg = 'bg',
    },
  },
  {
    str = 'left_rounded',
    hl = {
      fg = section_bg_color,
      bg = 'bg',
    },
  },
}

local right_sep = {
  {
    str = 'right_rounded',
    hl = {
      fg = section_bg_color,
      bg = 'bg',
    },
  },
}

table.insert(components.active[1], {
  provider = {
    name = 'vi_mode',
    opts = {
      show_mode_name = true
    }
  },
  icon = '',
  hl = function()
    return {
      name = require('feline.providers.vi_mode').get_mode_highlight_name(),
      fg = require('feline.providers.vi_mode').get_mode_color(),
      style = 'bold',
      bg = section_bg_color,
    }
  end,
  left_sep = left_sep,
  right_sep = right_sep
})

-- Component that shows file info
--[[ table.insert(components.active[1], {
  provider = 'file_info',
  hl = {
    fg = 'white',
    bg = section_bg_color,
    -- style = 'bold'
  },
  left_sep = left_sep,
  right_sep = right_sep,
  -- Uncomment the next line to disable file icons
  -- icon = ''
}) ]]

-- Component that shows current file size
--[[ components.active[1][3] = {
  provider = 'file_size',
  right_sep = {
    ' ',
    {
      str = 'slant_left_2_thin',
      hl = {
        fg = 'fg',
        bg = 'bg'
      }
    },
    ' '
  }
} ]]

-- Component that shows file encoding
--[[ components.active[2][1] = {
  provider = 'file_encoding'
} ]]

-- Component that shows current git branch
table.insert(components.active[1], {
  provider = 'git_branch',
  hl = {
    fg = 'fg',
    bg = section_bg_color,
    -- style = 'bold'
  },
  left_sep = left_sep,
  right_sep = right_sep,
})
table.insert(components.active[1], {
  provider = 'git_diff_added',
  hl = {
    fg = 'green',
    bg = section_bg_color,
  },
  right_sep = right_sep,
  left_sep = left_sep,
})

table.insert(components.active[1], {
  provider = 'git_diff_changed',
  hl = {
    fg = 'orange',
    bg = section_bg_color,
  },
  right_sep = right_sep,
  left_sep = left_sep,
})

table.insert(components.active[1], {
  provider = 'git_diff_removed',
  hl = {
    fg = 'red',
    bg = section_bg_color,
  },
  right_sep = right_sep,
  left_sep = left_sep,
})

local lsp_status_ok, lsp_status = pcall(require, 'lsp-status')
if lsp_status_ok then
  table.insert(components.active[1], {
    right_sep = right_sep,
    left_sep = left_sep,
    hl = {
      bg = section_bg_color,
    },
    provider = function()
      return lsp_status.status()
    end,
  })
end

-- if there's no git signgs it's section get stretched and fills the place between 1 and 2 sections
-- the code below prevents it
table.insert(components.active[1], {
  provider = ' ',
})

table.insert(components.active[2], {
  provider = 'diagnostic_errors',
  left_sep = left_sep,
  right_sep = right_sep,
  hl = {
    fg = 'red',
    bg = section_bg_color,
  },
  enabled = function()
    return lsp.diagnostics_exist()
  end,
})

table.insert(components.active[2], {
  provider = 'diagnostic_warnings',
  hl = {
    fg = 'orange',
    bg = section_bg_color,
  },
  left_sep = left_sep,
  right_sep = right_sep,
  enabled = function()
    return lsp.diagnostics_exist()
  end,
})

table.insert(components.active[2], {
  provider = 'diagnostic_hints',
  hl = {
    fg = 'aqua',
    bg = section_bg_color,
  },
  left_sep = left_sep,
  right_sep = right_sep,
  enabled = function()
    return lsp.diagnostics_exist()
  end,
})

table.insert(components.active[2], {
  provider = 'diagnostic_info',
  left_sep = left_sep,
  right_sep = right_sep,
  hl = {
    fg = 'yellow',
    bg = section_bg_color,
  },
  enabled = function()
    return lsp.diagnostics_exist()
  end,
})

table.insert(components.active[2], {
  provider = {
    name = 'file_type',
  },
  hl = {
    bg = section_bg_color,
  },
  left_sep = left_sep,
  right_sep = right_sep,
})

table.insert(components.active[2], {
  provider = 'line_percentage',
  hl = {
    fg = 'white',
    bg = section_bg_color,
    style = 'bold',
  },
  left_sep = left_sep,
  right_sep = right_sep,
})

table.insert(components.active[2], {
  provider = 'scroll_bar',
  left_sep = ' ',
  hl = {
    fg = 'green',
    bg = 'bg',
  },
})

feline.setup({
  components = components,
  force_inactive = {
    filetypes = {
      '^NvimTree$',
      '^packer$',
      '^startify$',
      '^fugitive$',
      '^fugitiveblame$',
      '^qf$',
    },
  },
})

if monokai_ok then
  local palette = monokai.classic
  feline.use_theme({
    fg = palette.base8,
    bg = palette.base2,
    black = palette.black,
    styblue = palette.aqua,
    green = palette.green,
    orange = palette.orange,
    red = palette.red,
    violet = palette.purple,
    white = palette.white,
    yellow = palette.yellow,
  })
end

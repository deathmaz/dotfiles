local wezterm = require 'wezterm'
local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)

local config = {}

config.tab_max_width = 80
config.window_decorations = 'NONE'
config.use_fancy_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.check_for_updates = false

config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.2cell',
  bottom = '0.2cell',
}

config.tab_bar_at_bottom = true

-- config.default_cursor_style = "BlinkingBlock"

config.font_size = 13.2
config.line_height = 1.2
config.cell_width = 0.9

config.color_scheme = 'Catppuccin Macchiato'
-- config.font = wezterm.font('Source Code Pro', { weight = 'Medium' })
config.font = wezterm.font('SauceCodePro Nerd Font Mono', {
  weight = 'Medium',
})
config.font_rules = {
  {
    intensity = 'Bold',
    italic = false,
    font = wezterm.font_with_fallback({
      'SauceCodePro Nerd Font Mono',
      weight = 'Medium'
    }),
  },
  {
    intensity = 'Bold',
    italic = true,
    font = wezterm.font_with_fallback({
      'SauceCodePro Nerd Font Mono',
      weight = 'Medium'
    }),
  },
  {
    intensity = 'Half',
    italic = false,
    font = wezterm.font_with_fallback({
      'SauceCodePro Nerd Font Mono',
      weight = 'Regular'
    }),
  },
}
config.keys = {
  {
    key = 'y',
    mods = 'CTRL|SHIFT',
    action = act.SwitchToWorkspace {
      name = 'default',
    },
  },
  {
    key = 'm',
    mods = 'CTRL|SHIFT',
    action = act.SwitchToWorkspace {
      name = 'music',
      spawn = {
        args = { 'ncmpcpp' },
      },
    },
  },
  {
    key = '9',
    mods = 'ALT',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
  },
  {
    key = 'W',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
  {
    key = 'd',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = '/home/maz/dotfiles',
      args = {
        '/home/maz/dotfiles/deathmaz/executable/scripts/bin/fzf-dotfiles.sh',
      },
    },
  },
  {
    key = 'w',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = '/home/maz/notes',
      args = {
        '/home/maz/execs/neovim/bin/nvim',
        '/home/maz/notes/todo.md',
      },
    },
  },
  {
    key = 'o',
    mods = 'CTRL|SHIFT|ALT',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = '/home/maz/notes',
      args = {
        '/home/maz/dotfiles/deathmaz/executable/scripts/bin/fzf-projects.sh',
      },
    },
  },
  {
    key = 'q',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentTab { confirm = false },
  },
  {
    key = 'v',
    mods = 'ALT',
    action = act.PasteFrom 'Clipboard',
  },
  --[[ {
    key = 'c',
    mods = 'ALT',
    action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
  }, ]]
  {
    key = '"',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = '{',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = '}',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'h',
    mods = 'SHIFT|CTRL',
    action = act.ActivateTabRelative(-1),
  },
  {
    key = '<',
    mods = 'SHIFT|CTRL',
    action = act.MoveTabRelative(-1),
  },
  {
    key = 'l',
    mods = 'SHIFT|CTRL',
    action = act.ActivateTabRelative(1),
  },
  {
    key = '>',
    mods = 'SHIFT|CTRL',
    action = act.MoveTabRelative(1),
  },
}

return config

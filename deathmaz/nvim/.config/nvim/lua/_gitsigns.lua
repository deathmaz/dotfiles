local ok, gitsigns = pcall(require, 'gitsigns');
if not ok then
  return
end

local icons = require('_icons')
gitsigns.setup {
  signs = {
    add          = {
      hl = 'GitSignsAdd',
      text = icons.box.LightVertical,
      numhl = 'GitSignsAddNr',
      linehl = 'GitSignsAddLn',
    },
    change       = {
      hl = 'GitSignsChange',
      text = icons.box.LightVertical,
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
    delete       = {
      hl = 'GitSignsDelete',
      text = icons.box.HeavyHorizontal,
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    topdelete    = {
      hl = 'GitSignsDelete',
      text = '‾',
      numhl = 'GitSignsDeleteNr',
      linehl = 'GitSignsDeleteLn',
    },
    changedelete = {
      hl = 'GitSignsChange',
      text = '~',
      numhl = 'GitSignsChangeNr',
      linehl = 'GitSignsChangeLn',
    },
  },
}

vim.keymap.set("n", "]h", function() gitsigns.next_hunk() end)
vim.keymap.set("n", "[h", function() gitsigns.prev_hunk() end)

local fzf_lua = require 'fzf-lua'
vim.keymap.set('n', '<space>g',
  function()
    local actions = gitsigns.get_actions()
    fzf_lua.fzf_exec(function(cb)
        for k, _ in pairs(actions) do
          cb(k)
        end
        cb()
      end,
      {
        actions = {
          ['default'] = function(selected)
            gitsigns[selected[1]]()
          end,
        },
        winopts = {
          height = 0.6,
          width = 0.6,
        }
      })
  end)

local ok, gitsigns = pcall(require, 'gitsigns');
if not ok then
  return
end

local icons = require('_icons')
gitsigns.setup {
  signs = {
    add          = {
      text = icons.box.LightVertical,
    },
    change       = {
      text = icons.box.LightVertical,
    },
    delete       = {
      text = icons.box.HeavyHorizontal,
    },
    topdelete    = {
      text = '‾',
    },
    changedelete = {
      text = '~',
    },
  },
}

vim.keymap.set("n", "]h", function()
  gitsigns.nav_hunk('next', {}, function()
    vim.cmd('normal zz')
  end)
end)
vim.keymap.set("n", "[h", function()
  gitsigns.nav_hunk('prev', {}, function()
    vim.cmd('normal zz')
  end)
end)

local fzf_lua = require 'fzf-lua'
vim.keymap.set({ 'n', 'v' }, '<space>g',
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

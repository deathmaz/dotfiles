vim.keymap.set('', '\\gs', function()
  vim.cmd.Git({
    mods = {
      vertical = true,
      split = 'topleft',
    },
  })
  local width = math.floor(vim.o.columns * 0.5)
  vim.cmd("vertical resize " .. width)
end)

-- Makes it possible for `:GBrowse` to work with netrw plugin disabled
-- The idea was taken from https://github.com/kyazdani42/nvim-tree.lua/issues/559#issuecomment-962593611
vim.api.nvim_create_user_command('Browse', function(opts)
  vim.cmd('silent !xdg-open ' .. vim.fn.shellescape(opts.args, true))
end, {
  nargs = 1
})

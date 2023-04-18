local fzf_lua_ok, fzf_lua = pcall(require, 'fzf-lua')

local opts = { buffer = true }
vim.keymap.set('n', '<leader>lc', '<cmd>:call mkdx#ToggleChecklist()<CR>', opts)
vim.keymap.set('n', '<leader>ll', '<cmd>:call mkdx#ToggleList()<CR>', opts)
vim.keymap.set('n', '<leader>j', '<cmd>:call mkdx#JumpToHeader()<CR>', opts)
vim.keymap.set('n', '<leader><leader>i', '<cmd>:call mkdx#GenerateOrUpdateTOC()<CR>', opts)
vim.keymap.set('n', '<leader>I', '<cmd>:call mkdx#QuickfixHeaders()<CR>', opts)
vim.keymap.set('n', '<leader>D', '<cmd>:call mkdx#QuickfixDeadLinks()<CR>', opts)

if fzf_lua_ok then
  vim.keymap.set('n', '<leader>H',
    function()
      local headers = vim.fn['mkdx#QuickfixHeaders'](0)
      fzf_lua.fzf_exec(function(cb)
        local color = fzf_lua.utils.ansi_codes
        for _, e in ipairs(headers) do
          cb(color.green(e['lnum'] .. ': ') .. color.blue(e['text']))
        end
        cb()
      end,
        {
          actions = {
            ["default"] = function(selected)
              local str = fzf_lua.utils.strsplit(selected[1], ':')
              vim.api.nvim_win_set_cursor(0, { tonumber(str[1]), 0 })
            end,
          },
          winopts = {
            height = 0.6,
            width = 0.6,
          }
        })
    end,
    opts)
end

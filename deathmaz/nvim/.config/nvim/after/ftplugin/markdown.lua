local fzf_lua_ok, fzf_lua = pcall(require, 'fzf-lua')

vim.opt_local.spell = true
vim.opt_local.textwidth = 80
vim.b.link_heading = ''

local opts = { buffer = true }
vim.keymap.set('n', '<leader>lc', '<Plug>(mkdx-toggle-checklist-n)', opts)
vim.keymap.set('v', '<leader>lc', '<Plug>(mkdx-toggle-checklist-v)', opts)
vim.keymap.set('n', '<leader>ll', '<cmd>:call mkdx#ToggleList()<CR>', opts)
-- vim.keymap.set('n', '<leader>j', '<cmd>:call mkdx#JumpToHeader()<CR>', opts)
-- vim.keymap.set('n', '<leader><leader>i', '<cmd>:call mkdx#GenerateOrUpdateTOC()<CR>', opts)
vim.keymap.set('n', '<f8>', '<cmd>:!markdown-toc -i %<CR>', opts)
-- vim.keymap.set('n', '<leader>I', '<cmd>:call mkdx#QuickfixHeaders()<CR>', opts)
vim.keymap.set('n', '<leader>D', '<cmd>:call mkdx#QuickfixDeadLinks()<CR>', opts)
vim.keymap.set('n', "<leader>'", '<Plug>(mkdx-toggle-quote-n)', opts)
vim.keymap.set('v', "<leader>'", '<Plug>(mkdx-toggle-quote-v)', opts)
vim.keymap.set('n', "<leader>[", '<cmd>:call mkdx#ToggleHeader()<CR>', opts)
vim.keymap.set('n', "\\l", vim.cmd.LinkConvertSingle, opts)

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

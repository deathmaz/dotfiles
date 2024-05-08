local functions = require('_functions')

local ok, fzf_lua = pcall(require, 'fzf-lua')
if not ok then
  return
end

local project_ok, project = pcall(require, 'project_nvim')

local opts = { noremap = true, silent = true }

fzf_lua.setup({
  files = {
    fzf_opts = {
      ["--ansi"] = true,
    }
  },
  grep = {
    rg_glob = true,
    rg_opts =
    "--column --hidden --glob '!.git' --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
    --[[ winopts = {
      preview = {
        horizontal = 'hidden'
      },
    }, ]]
  },
  winopts = {
    height  = 0.95,
    width   = 0.95,
    preview = {
      default = 'bat',
      horizontal = 'right:40%',
      layout = 'flex',
    },
  },
  previewers = {
    git_diff = {
      pager = "delta",
    },
  },
  manpages = { previewer = "man_native" },
  helptags = { previewer = "help_native" },
  fzf_opts = {
    -- ['--layout'] = 'reverse-list',
  },
  defaults = {
    git_icons = false,
    file_icons = false,
    formatter = "path.filename_first",
  },
})

vim.keymap.set("n", "\\b", fzf_lua.git_branches, opts)

vim.keymap.set('n', '<leader>f', function()
  fzf_lua.files()
end, opts)

vim.keymap.set('n', '<leader>w', function()
  fzf_lua.files({
    cwd = functions.find_git_root(),
  })
end, opts)

vim.keymap.set('n', '<leader><leader>l', fzf_lua.blines, opts)

vim.keymap.set('n', '<leader>L', function()
  fzf_lua.grep_project()
end, opts)

vim.keymap.set('n', '\\L', function()
  fzf_lua.grep_project({
    cwd = functions.find_git_root(),
  })
end, opts)

vim.keymap.set('n', '<leader>v', fzf_lua.buffers, opts)

vim.keymap.set('n', '\\f', fzf_lua.git_status, opts)

vim.keymap.set('n', '\\h', fzf_lua.help_tags, opts)

vim.keymap.set({ 'n', 'v' }, '\\c', fzf_lua.commands, opts)

vim.keymap.set('n', '<leader>o', fzf_lua.oldfiles, opts)

vim.keymap.set('n', '\\y', fzf_lua.tmux_buffers, opts)

vim.keymap.set('n', '<leader>ag', function()
  fzf_lua.grep_cword({
    cwd = functions.find_git_root(),
  })
end, opts)

vim.keymap.set('x', '<leader>ag', function()
  fzf_lua.grep_visual({
    cwd = functions.find_git_root(),
  })
end, opts)

vim.keymap.set('n', '<leader>ef',
  function()
    fzf_lua.files({ cwd = vim.fn.expand('%:p:h') })
    --[[ fzf_lua.fzf_exec("rg --files --color=always --hidden --no-ignore " .. vim.fn.expand('%:h'), {
      previewer = 'bat',
      actions = {
        ['default'] = fzf_lua.actions.file_edit,
        ["ctrl-s"]  = fzf_lua.actions.file_split,
        ["ctrl-v"]  = fzf_lua.actions.file_vsplit,
        ["ctrl-t"]  = fzf_lua.actions.file_tabedit,
      }
    }) ]]
  end,
  opts)

vim.keymap.set('n', '\\t', function()
  fzf_lua.asynctasks()
end, opts)

if project_ok then
  vim.keymap.set('n', '\\p',
    function()
      local history = require("project_nvim.utils.history")
      fzf_lua.fzf_exec(function(cb)
          local results = history.get_recent_projects()
          for _, e in ipairs(results) do
            cb(e)
          end
          cb()
        end,
        {
          actions = {
            ['default'] = {
              function(selected)
                fzf_lua.files({ cwd = selected[1] })
              end,
            },
            ['ctrl-d'] = {
              function(selected)
                history.delete_project({ value = selected[1] })
              end,
              fzf_lua.actions.resume
            }
          }
        })
    end,
    opts)
end

vim.keymap.set('i', '<c-x><c-f>',
  function()
    fzf_lua.files({
      formatter = "",
      actions = {
        ["default"] = function(selected)
          local pos = vim.api.nvim_win_get_cursor(0)[2]
          local line = vim.api.nvim_get_current_line()
          local nline = line:sub(0, pos) .. selected[1] .. line:sub(pos + 1)
          vim.api.nvim_set_current_line(nline)
        end,
      }
    })
  end, opts)

vim.cmd [[ command! Rg execute 'lua require("fzf-lua").grep_project()' ]]

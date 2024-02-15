-- All credits to https://github.com/ibhagwan/nvim-lua/blob/main/lua/autocmd.lua

local aucmd = vim.api.nvim_create_autocmd

local function augroup(name, fnc)
  fnc(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- Display help|man in vertical splits and map 'q' to quit
augroup('Help', function(g)
  local function open_vert()
    -- do nothing for floating windows or if this is
    -- the fzf-lua minimized help window (height=1)
    local cfg = vim.api.nvim_win_get_config(0)
    if cfg and (cfg.external or cfg.relative and #cfg.relative>0)
      or vim.api.nvim_win_get_height(0) == 1 then
      return
    end

    local width = math.floor(vim.o.columns*0.5)
    vim.cmd("wincmd L")
    vim.cmd("vertical resize " .. width)
    vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = true })
  end
  aucmd("FileType", {
    group = g,
    pattern = 'help,man',
    callback = open_vert,
  })
  -- we also need this auto command or help
  -- still opens in a split on subsequent opens
  aucmd("BufEnter", {
    group = g,
    pattern = '*.txt',
    callback = function()
      if vim.bo.buftype == 'help' then
        open_vert()
      end
    end
  })
  aucmd("BufHidden", {
    group = g,
    pattern = 'man://*',
    callback = function()
      if vim.bo.filetype == 'man' then
        local bufnr = vim.api.nvim_get_current_buf()
        vim.defer_fn(function()
          if vim.api.nvim_buf_is_valid(bufnr) then
            vim.api.nvim_buf_delete(bufnr, {force=true})
          end
        end, 0)
      end
    end
  })
end)

augroup('ActiveWinCursorLine', function(g)
  -- Highlight current line only on focused window
  aucmd({"WinEnter","BufEnter", "InsertLeave"}, {
    group = g,
    pattern = '*',
    command = 'if ! &cursorline && ! &pvw | setlocal cursorline | endif'
  })
  aucmd({"WinLeave","BufLeave","InsertEnter"}, {
    group = g,
    pattern = '*',
    command = 'if &cursorline && ! &pvw | setlocal nocursorline | endif'
  })
end)

augroup('Dotfiles', function(g)
  aucmd({'BufWritePost'}, {
    group = g,
    pattern = 'sxhkdrc',
    command = '!pkill -USR1 -x sxhkd && notify-send "sxhkd reloaded"'
  })
end)

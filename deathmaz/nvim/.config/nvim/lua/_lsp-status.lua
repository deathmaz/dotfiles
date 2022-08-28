local M = {}

local ok, lsp_status = pcall(require, 'lsp-status')

M.init = function()
  if ok then
    lsp_status.config({
      -- diagnostics = false,
      status_symbol = '🍀',
    })
    lsp_status.register_progress()
  end
end

M.update_capabilities = function(capabilities)
  if (ok) then
    return vim.tbl_extend('keep', capabilities or {}, lsp_status.capabilities);
  else
    return vim.tbl_extend('keep', capabilities or {}, {});
  end
end

M.attach = function(client)
  if ok then
    lsp_status.on_attach(client)
  end
end

return M

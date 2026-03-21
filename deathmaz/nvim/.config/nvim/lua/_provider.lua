local M = {}
M.is_coc = function() return vim.g.lsp_provider == "coc" end
M.is_native = function() return vim.g.lsp_provider == "native" end
return M

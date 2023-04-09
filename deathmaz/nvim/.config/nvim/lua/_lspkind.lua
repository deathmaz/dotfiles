local lspkind_ok, lspkind = pcall(require, 'lspkind')
if not lspkind_ok then
  return
end

lspkind.init({
  preset = 'codicons',
    symbol_map = {
    Copilot = "",
  },
})

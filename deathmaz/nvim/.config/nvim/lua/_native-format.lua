local ok, conform = pcall(require, "conform")
if not ok then
  return
end

-- JS/TS/Vue formatting is handled by eslint LSP (EslintFixAll on save in _native-lsp.lua)
-- conform only handles non-JS formatters — no LSP fallback to avoid ts_ls reformatting
conform.setup({
  formatters_by_ft = {
    go = { "gofmt" },
    rust = { "rustfmt" },
    lua = { "stylua" },
  },
  format_on_save = {
    timeout_ms = 3000,
    lsp_format = "never",
  },
})

local ok, saga = pcall(require, 'lspsaga')
if not ok then
  return
end

saga.init_lsp_saga({
  border_style = "rounded",
  symbol_in_winbar = {
    in_custom = true
  },
  code_action_lightbulb = {
    enable = false,
    sign = true,
    enable_in_insert = true,
    sign_priority = 20,
    virtual_text = false,
  },
})

vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", "gS", "<Cmd>Lspsaga signature_help<CR>", { silent = true })
vim.keymap.set("n", "<leader>gr", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
vim.keymap.set("n", "gl", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })

vim.keymap.set("n", "[d", function()
  require("lspsaga.diagnostic").goto_prev()
end, { silent = true })
vim.keymap.set("n", "]d", function()
  require("lspsaga.diagnostic").goto_next()
end, { silent = true })

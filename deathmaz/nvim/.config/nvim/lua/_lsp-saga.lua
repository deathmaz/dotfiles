local ok, saga = pcall(require, 'lspsaga')
if not ok then
  return
end

saga.setup({
  border_style = "rounded",
  symbol_in_winbar = {
    enable = true,
    separator = ' ' .. require('_icons').ui.ChevronRight .. ' ',
  },
  preview = {
    lines_above = 5,
  },
  ui = {
    kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
    border = "rounded",
  },
  lightbulb = {
    enable = false,
    sign = true,
    enable_in_insert = true,
    sign_priority = 20,
    virtual_text = false,
  },
  rename = {
    quit = '<esc>',
  },
})

-- vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
-- vim.keymap.set("n", "gS", "<Cmd>Lspsaga signature_help<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>gr", "<cmd>Lspsaga rename<CR>", { silent = true })
-- vim.keymap.set("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
-- vim.keymap.set("n", "gl", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
-- vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })

--[[ vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true }) ]]

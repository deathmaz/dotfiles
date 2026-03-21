local vscode = require('vscode')

vim.keymap.set({ "n" }, "[h", function()
  vscode.action("workbench.action.editor.previousChange")
end)

vim.keymap.set({ "n" }, "]h", function()
  vscode.action("workbench.action.editor.nextChange")
end)

vim.keymap.set({ "n" }, "\\s", function()
  vscode.action("workbench.action.gotoSymbol")
end)

vim.keymap.set({ "n" }, "<leader>f", function()
  vscode.action("workbench.action.quickOpen")
end)

vim.keymap.set({ "n" }, "<leader>B", function()
  vscode.action("workbench.action.toggleSidebarVisibility")
end)

vim.keymap.set({ "n" }, "<leader>K", function()
  vscode.action("workbench.action.toggleAuxiliaryBar")
end)

vim.keymap.set({ "n" }, "\\t", function()
  vscode.action("workbench.action.tasks.runTask")
end)

vim.keymap.set({ "n" }, "<space><space>q", function()
  vscode.action("workbench.action.closePanel")
end)

vim.keymap.set({ "n", "x" }, "<leader>ag", function()
  local query
  if vim.fn.mode():match("[vV\22]") then
    vim.cmd([[normal! "zy]])
    query = vim.fn.getreg("z")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
  else
    query = vim.fn.expand("<cword>")
  end
  vscode.action("workbench.action.findInFiles", { args = { query = query } })
end)

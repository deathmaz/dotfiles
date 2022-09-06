local ok, navic = pcall(require, 'nvim-navic')
if not ok then
  return
end

navic.setup({
  highlight = true,
})

-- Uncomment to cusomize navic colors
-- vim.cmd[[ highlight link NavicIconsFunction TSFunction ]]
-- vim.cmd[[ highlight link NavicIconsClass CmpItemKindClass ]]
-- vim.cmd[[ highlight link NavicIconsModule CmpItemKindModule ]]
-- vim.cmd[[ highlight link NavicIconsNamespace TSNamespace ]]
-- vim.cmd[[ highlight link NavicIconsMethod CmpItemKindMethod ]]
-- vim.cmd[[ highlight link NavicIconsProperty CmpItemKindProperty ]]
-- vim.cmd[[ highlight link NavicIconsField CmpItemKindField ]]
-- vim.cmd[[ highlight link NavicIconsConstructor TSConstructor ]]
-- vim.cmd[[ highlight link NavicIconsEnum CmpItemKindEnum ]]
-- vim.cmd[[ highlight link NavicIconsInterface CmpItemKindInterface ]]
-- vim.cmd[[ highlight link NavicIconsVariable CmpItemKindProperty ]]
-- vim.cmd[[ highlight link NavicIconsConstant TSConstant ]]
-- vim.cmd[[ highlight link NavicIconsString TSString ]]
-- vim.cmd[[ highlight link NavicIconsNumber TSNumber ]]
-- vim.cmd[[ highlight link NavicIconsBoolean TSBoolean ]]
-- vim.cmd[[ highlight link NavicIconsArray CmpItemKindProperty ]]
-- vim.cmd[[ highlight link NavicIconsObject CmpItemKindProperty ]]
-- vim.cmd[[ highlight link NavicIconsKey CmpItemKindProperty ]]
-- vim.cmd[[ highlight link NavicIconsNull CmpItemKindField ]]
-- vim.cmd[[ highlight link NavicIconsEnumMember TSNumber ]]
-- vim.cmd[[ highlight link NavicIconsStruct CmpItemKindProperty ]]
-- vim.cmd[[ highlight link NavicIconsEvent CmpItemKindEvent ]]
-- vim.cmd[[ highlight link NavicIconsOperator CmpItemKindOperator ]]
-- vim.cmd[[ highlight link NavicIconsTypeParameter CmpItemKindProperty ]]
-- vim.cmd[[ highlight link NavicText Normal ]]
-- vim.cmd[[ highlight link NavicSeparator Normal ]]
-- vim.cmd[[ highlight link NavicIconsPackage CmpItemKindProperty ]]
-- vim.cmd[[ highlight link NavicIconsFile CmpItemKindProperty ]]

local ok, _ = pcall(require, 'nvim-treesitter')
if not ok then
  return
end

local ensureInstalled = {
  'javascript',
  'typescript',
  'tsx',
  'html',
  'php',
  -- 'css',
  'python',
  'regex',
  'json',
  'bash',
  'lua',
  'jsdoc',
  'vue',
  'rust',
  'go',
  'dockerfile',
  'vim',
  'yaml',
  'gitignore',
  'markdown_inline',
  'markdown',
  'c',
  'vimdoc',
  'query',
  'gitcommit',
  'git_config',
  'sxhkdrc',
  'tmux',
}
local alreadyInstalled = require("nvim-treesitter.config").get_installed()
local parsersToInstall = vim.iter(ensureInstalled)
    :filter(function(parser) return not vim.tbl_contains(alreadyInstalled, parser) end)
    :totable()
require("nvim-treesitter").install(parsersToInstall)

for _, parser in pairs(alreadyInstalled) do
  local filetypes = vim.treesitter.language.get_filetypes(parser)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = filetypes,
    callback = function()
      vim.treesitter.start()
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

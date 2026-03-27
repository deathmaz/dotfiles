local ok, _ = pcall(require, 'nvim-treesitter')
if not ok then
  return
end


local ensureInstalled = {
  'javascript',
  'astro',
  'typescript',
  'tsx',
  'html',
  'php',
  'css',
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
  'dart',
  'sql',
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

local provider = require('_provider')

-- Treesitter textobjects (native LSP only — coc provides its own)
if provider.is_native() then
  local ts_ok, ts_textobjects = pcall(require, "nvim-treesitter-textobjects")
  if ts_ok then
    -- Vue excluded — query incompatibility ("Invalid node type directive_argument")
    local excluded_ft = { vue = true }

    local function select_textobject(query)
      return function()
        if excluded_ft[vim.bo.filetype] then return end
        require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
      end
    end

    ts_textobjects.setup({
      select = {
        lookahead = true,
        selection_modes = {
          ["@function.outer"] = "V",
          ["@class.outer"] = "V",
        },
      },
    })

    vim.keymap.set({ "x", "o" }, "if", select_textobject("@function.inner"))
    vim.keymap.set({ "x", "o" }, "af", select_textobject("@function.outer"))
    vim.keymap.set({ "x", "o" }, "ic", select_textobject("@class.inner"))
    vim.keymap.set({ "x", "o" }, "ac", select_textobject("@class.outer"))
  end
end

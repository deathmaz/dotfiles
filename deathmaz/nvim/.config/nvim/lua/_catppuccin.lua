local ok, catppuccin = pcall(require, 'catppuccin')
if not ok then
  return
end

catppuccin.setup({
  compile = {
    enable = true,
  },
  integrations = {
    lsp_saga = true,
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    treesitter_context = true,
    treesitter = true,
    native_lsp = {
      enabled = true,
    },
    navic = {
      enabled = true,
      custom_bg = "NONE",
    },
  }
})

vim.cmd [[colorscheme catppuccin]]

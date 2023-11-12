local ok, catppuccin = pcall(require, 'catppuccin')
if not ok then
  return
end

catppuccin.setup({
  custom_highlights = function(colors)
    return {
      DiagnosticUnderlineError = {
        style = {
          gui = 'undercurl',
        },
      },
      DiagnosticUnderlineWarn = {
        style = {
          gui = 'undercurl',
        },
      },
      DiagnosticUnderlineInfo = {
        style = {
          gui = 'undercurl',
        },
      },
      DiagnosticUnderlineHint = {
        style = {
          gui = 'undercurl',
        },
      },
      LspInlayHint = {
        bg = colors.none,
      },
    }
  end,
  flavour = "macchiato",
  compile = {
    enable = true,
  },
  integrations = {
    lsp_saga = false,
    mason = true,
    cmp = true,
    harpoon = true,
    markdown = true,
    semantic_tokens = true,
    gitsigns = true,
    nvimtree = true,
    indent_blankline = {
      enabled = false,
      colored_indent_levels = false,
    },
    treesitter_context = true,
    treesitter = true,
    native_lsp = {
      enabled = true,
    },
    navic = {
      enabled = false,
      custom_bg = "NONE",
    },
  },
  no_italic = true,
})

vim.cmd [[colorscheme catppuccin]]

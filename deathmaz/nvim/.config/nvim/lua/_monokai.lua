local ok, monokai = pcall(require, 'monokai')
if not ok then
  return
end

local palette = monokai.classic
monokai.setup {
  palette = {
    diff_add = '#002800',
    diff_remove = '#3C0015',
  },
  custom_hlgroups = {
    FoldColumn = {
      bg = palette.base2,
      fg = palette.base5,
    },
    GitSignsChange = {
      bg = palette.base2,
      fg = '#48679D',
    },
    CocFloating = {
      -- bg = palette.base4,
    },
    WinBar = {
      gui = 'NONE',
    },
    NormalFloat = {
      bg = palette.base3,
    },
    TreesitterContextLineNumber = {
      bg = palette.base3,
    },
    DiffDelete = {
      fg = palette.grey,
      bg = palette.diff_remove,
    },
    IndentBlanklineChar = {
      fg = palette.base3,
    },
    IndentBlanklineContextChar = {
      fg = palette.base6,
    },
    IndentBlanklineContextStart = {
      fg = palette.base6,
    },
    LspSagaHoverBorder = {
      fg = palette.orange,
    },
    LspSagaRenameBorder = {
      fg = palette.aqua,
    },
    LspSagaDiagnosticSource = {
      fg = palette.orange,
    },
    LspSagaDiagnosticBorder = {
      fg = palette.purple,
    },
    LspSagaDiagnosticHeader = {
      fg = palette.green,
    },
  }
}

return {
  init_options = {
    documentFormatting = true,
  },
  settings = {
    rootMarkers = {".git/"},
    languages = {
      go = {
        {
          formatCommand = 'gofumpt',
          formatStdin = true,
        },
        {
          formatCommand = 'golines',
          formatStdin = true,
        },
        {
          formatCommand = 'goimports',
          formatStdin = true,
        }
      },
      markdown = {
        {
          formatCommand = 'markdown-toc -i ${INPUT}',
          formatStdin = false,
        },
      },
    }
  }
}

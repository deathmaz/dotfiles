local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

configs.setup {
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
  },
  endwise = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    use_languagetree = false,
    disable = {
      'css'
    },
    -- additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
                                 -- mappings for incremental selection (visual mappings)
      init_selection = 'gnn',    -- maps in normal mode to init the node/scope selection
      node_incremental = "grn",  -- increment to the upper named parent
      scope_incremental = "grc", -- increment to the upper scope (as defined in locals.scm)
      node_decremental = "grm",  -- decrement to the previous node
    }
  },
  autotag = {
    enable = true,
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = { ["<C-j>"] = "@function.outer" },
      goto_previous_start = { ["<C-k>"] = "@function.outer" },
    },

    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["in"] = "@property.name",
        ["iv"] = "@property.value",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      },
    },
  },
  ensure_installed = {
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
    -- 'scss',
  } -- one of 'all', 'language', or a list of languages
}

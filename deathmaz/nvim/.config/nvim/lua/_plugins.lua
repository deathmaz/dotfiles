return {
  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',
  {
    'ibhagwan/smartyank.nvim',
    config = function()
      require('_smartyank')
    end,
    event = 'VeryLazy',
  },

  {
    'jakewvincent/mkdnflow.nvim',
    config = true,
    opts = {
      mappings = {
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
        MkdnToggleToDo = { { 'n', 'v' }, '<M-f>' },
        MkdnDestroyLink = { 'n', '<M-d>' },
      },
      perspective = {
        priority = 'current',
      },
      to_do = {
        symbols = { ' ', '-', 'x' },
        complete = 'x'
      },
    },
    enabled = true,
  },

  {
    'stevearc/oil.nvim',
    opts = {
      columns = {
        "icon",
        "permissions"
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-s>"] = false,
        ["<C-v>"] = "actions.select_vsplit",
        ["-"] = false,
        ["<BS>"] = "actions.parent",
      }
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    'SidOfc/mkdx',
    ft = 'markdown',
    init = function()
      vim.g['mkdx#settings'] = {
        map = {
          enable = 0,
        },
        toc = {
          update_on_write = 0,
        },
        checkbox = {
          toggles = { ' ', 'x' }
        }
      }
    end,
    enabled = true
  },

  {
    'chrisbra/csv.vim',
    ft = 'csv',
    init = function()
      vim.g.csv_default_delim = ';'
      vim.g.csv_delim = ';'
    end,
    enabled = true,
  },

  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
    opts = {
      minimumBufferNum = 5,
    }
  },

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require('_copilot')
    end,
    enabled = false,
  },

  {
    'gaoDean/autolist.nvim',
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
    },
    config = function()
      require('_autolist')
    end,
    enabled = false,
  },

  {
    'kyazdani42/nvim-tree.lua',
    event = 'VeryLazy',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('_nvim-tree')
    end,
    enabled = false,
  },

  {
    'andymass/vim-matchup',
  },
  {
    'whiteinge/diffconflicts',
  },
  {
    'deathmaz/fzf-lua-asynctasks',
    dependencies = { 'ibhagwan/fzf-lua' },
    config = function()
      require('_fzf-lua-asynctasks')
    end,
    event = 'VeryLazy',
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('_gitsigns')
    end,
    event = 'VeryLazy',
  },
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    config = function()
      require('_diffview')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    config = function()
      require('_telescope')
    end,
    enabled = false,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    enabled = false,
  },

  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require('_navic')
    end,
    enabled = false,
  },

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require('_project')
    end,
  },

  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    config = function()
      require('_octo')
    end,
    enabled = false,
  },

  {
    'kwkarlwang/bufresize.nvim',
    -- module = 'bufresize',
    setup = function()
      vim.api.nvim_create_autocmd('VimResized', {
        callback = function()
          require('bufresize').resize()
        end,
      })
    end,
    enabled = false,
  },
  {
    'ThePrimeagen/harpoon',
    event = 'VeryLazy',
    config = function()
      require("harpoon").setup({
        menu = {
          width = 80,
        }
      })
      vim.keymap.set('n', '<leader>ha', require("harpoon.mark").add_file)
      vim.keymap.set('n', '<leader>hm', require("harpoon.ui").toggle_quick_menu)
      vim.keymap.set('n', '<leader>h1', function() require("harpoon.ui").nav_file(1) end)
      vim.keymap.set('n', '<leader>h2', function() require("harpoon.ui").nav_file(2) end)
      vim.keymap.set('n', '<leader>h3', function() require("harpoon.ui").nav_file(3) end)
      vim.keymap.set('n', '<leader>h4', function() require("harpoon.ui").nav_file(4) end)
    end,
    enabled = true,
  },
  {
    'bfredl/nvim-miniyank',
    event = 'VeryLazy'
  },
  {
    'folke/todo-comments.nvim',
    -- cmd = { 'TodoQuickFix', 'TodoTrouble', 'TodoTelescope' },
    config = function()
      require('_todo-comments')
    end,
  },
  {
    "rrethy/vim-hexokinase",
    build = "make hexokinase",
    config = function()
      require('_hexokinase')
    end,
    event = 'VeryLazy'
  },
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      require('bqf').setup({
        auto_resize_height = false,
        preview = {
          auto_preview = false,
        }
      })
    end,
  },
  {
    'arthurxavierx/vim-caser',
    event = 'VeryLazy'
  },
  {
    'fatih/vim-go',
    build = ':GoUpdateBinaries',
    ft = { 'go' },
    enabled = false,
  },
  {
    'potamides/pantran.nvim',
    cmd = { 'Pantran' },
    enabled = false,
  },

  {
    "dnlhc/glance.nvim",
    cmd = "Glance",
    config = true,
    enabled = false,
  },
  {
    "danymat/neogen",
    cmd = { 'Neogen' },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    branch = 'v3',
    config = function()
      require('_indent-blankline')
    end,
    event = 'VeryLazy',
    enabled = false,
  },

  --[[  {
  'lambdalisue/fern.vim',
  branch = 'main',
  }
   'lambdalisue/fern-git-status.vim'
   'lambdalisue/fern-hijack.vim' ]]
  {
    'lambdalisue/suda.vim',
    config = function()
      vim.g.suda_smart_edit = true
      vim.g['suda#prompt'] = "Type sudo password: "
    end
  },

  {
    'dhruvasagar/vim-table-mode',
    cmd = 'TableModeToggle',
  },
  {
    "MTDL9/vim-log-highlighting",
    ft = "log",
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'VeryLazy',
    config = function()
      require('_tree-sitter')
    end,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects'
      },
      {
        'windwp/nvim-ts-autotag',
      },
      {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require('_nvim-treesitter-context')
        end,
      },
      {
        'RRethy/nvim-treesitter-endwise',
      },
    },
  },
  {
    'abecodes/tabout.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      require('_tabout')
    end,
    enabled = false,
  },

  { "folke/neodev.nvim" },

-- LSP
  {
    'simrat39/rust-tools.nvim',
  },

  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require('_lsp-saga')
    end,
    event = 'VeryLazy',
    enabled = false,
  },

  {
    'lukas-reineke/lsp-format.nvim',
    config = function()
      require("lsp-format").setup({
        debug = true,
      })
    end
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    enabled = false,
    config = function ()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")
      null_ls.setup({
        on_attach = function(client, bufnr)
          require('lsp-format').on_attach(client)
          --[[ if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              pattern = {
                "*.md",
              },
              group = augroup,
              -- buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end ]]
        end,
        sources = {
          -- null_ls.builtins.formatting.rustywind,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.formatting.markdown_toc,
        },
      })
    end
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  {
    "ray-x/lsp_signature.nvim",
    event = 'VeryLazy',
    -- https://github.com/hrsh7th/nvim-cmp/issues/1613
    enabled = false,
  },
  { "b0o/SchemaStore.nvim" },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require('_lsp-lines')
    end,
    event = 'VeryLazy',
  },
  {
    "j-hui/fidget.nvim",
    config = function()
      require('_fidget')
    end,
    enabled = false,
  },
  {
    'onsails/lspkind.nvim',
    config = function()
      require('_lspkind')
    end,
    event = 'VeryLazy',
  },
  {
    'nvim-lua/lsp-status.nvim',
    enabled = false,
  },

  {
    'axelvc/template-string.nvim',
    config = function()
      require('_template-string')
    end,
  },

  {
    'AndrewRadev/splitjoin.vim',
    config = function()
      require('_splitjoin')
    end,
    enabled = false,
  },

  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('_luasnip')
    end
  },
  {
    'rafamadriz/friendly-snippets',
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("_cmp")
    end,
    event = 'InsertEnter',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      {
        'zbirenbaum/copilot-cmp',
        config = function()
          require("copilot_cmp").setup()
        end,
        enabled = false,
      }
    }
  },
  {
    'https://gitlab.com/yorickpeterse/nvim-dd.git',
    config = function()
      require('dd').setup()
    end
  },

  {
    'psliwka/vim-dirtytalk',
    build = ':DirtytalkUpdate',
    config = function()
      -- https://github.com/psliwka/vim-dirtytalk/issues/25#issuecomment-1399267808
      vim.opt.rtp:append(vim.fn.stdpath 'data' .. '/site')
    end,
  },

  {
    'gbprod/substitute.nvim',
    enabled = false,
    event = 'VeryLazy',
    config = function()
      require('substitute').setup()
      --[[ vim.keymap.set("n", "T", function()
  require('substitute').operator()
  end, { noremap = true })
  vim.keymap.set("x", "T", function()
  require('substitute').visual()
  end, { noremap = true }) ]]
      vim.keymap.set("n", "X", function()
        require('substitute.exchange').operator()
      end, { noremap = true })
      vim.keymap.set("x", "X", function()
        require('substitute.exchange').visual()
      end, { noremap = true })
      vim.keymap.set("n", "Xc", function()
        require('substitute.exchange').cancel()
      end, { noremap = true })
    end,
  },

  -- due to https://github.com/neovim/neovim/issues/12587
  -- 'antoinemadec/FixCursorHold.nvim',

  {
    'neoclide/coc.nvim',
    branch = 'pum',
    build = 'yarn install --frozen-lockfile',
    enabled = false,
  },
  {
    'antoinemadec/coc-fzf',
    enabled = false,
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require('_ufo')
    end,
    enabled = false,
  },
  {
    'freddiehaddad/feline.nvim',
    config = function()
      require('_feline')
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    enabled = false,
  },
  {
    'Wansmer/treesj',
    keys = { '<space>m', '<space>j', '<space>s' },
    config = function()
      require('treesj').setup({
        max_join_length = 300,
      })
    end,
  },
  {
    'wincent/ferret',
    event = 'VeryLazy',
  },
  {
    'wincent/command-t',
    build = 'cd lua/wincent/commandt/lib && make',
    init = function()
      vim.g.CommandTPreferredImplementation = 'lua'
    end,
    config = function()
      require('wincent.commandt').setup()
    end,
    enabled = false,
  },

  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-surround',
  'tpope/vim-eunuch',
  'tpope/vim-unimpaired',
  'tpope/vim-dispatch',
  {
    'tpope/vim-rsi'
  },
  {
    'ron89/thesaurus_query.vim',
    cmd = {
      'Thesaurus',
      'ThesaurusQueryLookupCurrentWord',
      'ThesaurusQueryReplaceCurrentWord',
      'ThesaurusQueryReplace'
    }
  },

  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('_fzf-lua')
    end,
    event = 'VeryLazy',
  },
  {
    'chaoren/vim-wordmotion',
    enabled = false,
  },

  {
    'junegunn/gv.vim',
    cmd = 'GV'
  },
  --[[  {
  'junegunn/fzf',
  build = function() vim.fn['fzf#install']() end,
  } ]]
  {
    'junegunn/fzf.vim',
    enabled = false,
  },
  {
    'junegunn/limelight.vim',
    cmd = 'Limelight'
  },
  {
    'junegunn/vim-easy-align',
    event = 'VeryLazy',
  },
  'junegunn/vim-slash',
  {
    'junegunn/vim-emoji',
  },
  {
    'othree/html5.vim',
    enabled = false
  },
  {
    'mattn/emmet-vim',
    init = function()
      vim.cmd [[
        let g:user_emmet_install_global = 0
        augroup Emmet
            autocmd!
            autocmd FileType blade EmmetInstall
        augroup END
      ]]
    end,
    enabled = false,
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('_autopairs')
    end,
    enabled = false,
  },

  {
    'LunarWatcher/auto-pairs',
    lazy = false,
    config = function()
      require('_vim-autopairs')
    end,
    enabled = true,
  },

  {
    'mhinz/vim-sayonara',
    cmd = 'Sayonara'
  },
  'mattn/webapi-vim',
  'wellle/targets.vim',
  'elzr/vim-json',
  {
    'fladson/vim-kitty',
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app & yarn install',
    ft = 'markdown',
    cmd = 'MarkdownPreview',
  },
  {
    'dyng/ctrlsf.vim',
    cmd = 'CtrlSF'
  },
  {
    't9md/vim-choosewin',
    enabled = false
  },
  {
    's1n7ax/nvim-window-picker',
    version = 'v1.*',
    config = function()
      require('_window-picker')
    end,
    event = 'VeryLazy',
  },
  'kana/vim-textobj-user',
  {
    -- TODO: this one throws error on startup
    'kana/vim-textobj-indent',
    enabled = false,
  },
  {
    "lukas-reineke/headlines.nvim",
    ft = "markdown",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      markdown = {
        fat_headlines = false,
      },
    },
    enabled = true,
  },
  {
    'whatyouhide/vim-textobj-xmlattr',
    ft = { 'html', 'vue', 'blade' }
  },
  {
    'rhysd/accelerated-jk',
    enabled = false,
  },
  {
    'jwalton512/vim-blade',
    ft = 'blade',
  },

  {
    'skywind3000/asynctasks.vim',
    config = function()
      require('_asynctasks')
    end,
    event = { 'BufWinEnter', 'BufNewFile' },
    cmd = { 'AsyncTask', 'AsyncTaskMacro', 'AsyncTaskList', 'AsyncTaskEdit' }
  },
  {
    'skywind3000/asyncrun.vim',
    cmd = { 'AsyncRun', 'AsyncStop' }
  },

  {
    'numToStr/Comment.nvim',
    event = { 'BufWinEnter', 'BufNewFile' },
    config = function()
    require('Comment').setup({
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
    end,
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config  = function()
          require('ts_context_commentstring').setup {
            enable_autocmd = false,
            skip_ts_context_commentstring_module = true,
          }
        end
      },
    },
  },

  {
    "SmiteshP/nvim-gps",
    dependencies = "nvim-treesitter/nvim-treesitter",
    enabled = false,
  },

  {
    'anuvyklack/hydra.nvim',
    event = 'VeryLazy',
    dependencies = 'anuvyklack/keymap-layer.nvim',
    config = function()
      require('_hydra')
    end
  },

  -- Colorschemes
  --  'projekt0n/github-nvim-theme'
  --  'chriskempson/base16-vim'
  --  'crusoexia/vim-monokai'
  {
    'glepnir/zephyr-nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('zephyr')
    end,
    enabled = false,
  },
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup({
        style = 'deep'
      })
      require('onedark').load()
    end,
    enabled = false,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd("colorscheme nightfox")
    end,
    enabled = false,
  },
  {
    'tanvirtin/monokai.nvim',
    config = function()
      require('_monokai')
    end,
    enabled = false,
  },
  {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
    enabled = false,
  },
  {
    'ishan9299/nvim-solarized-lua',
    config = function()
      vim.cmd('colorscheme solarized-high')
    end,
    enabled = false,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    build = ":CatppuccinCompile",
    config = function()
      require('_catppuccin')
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    config = function ()
      require('_lualine')
    end
  },
  {
    'Lokaltog/vim-monotone',
    enabled = false,
  },

  {
    enabled = false,
    'cranberry-clockworks/coal.nvim',
  },

  {
    'kvrohit/rasmus.nvim',
    setup = function()
      -- vim.g.rasmus_variant = "monochrome"
    end,
    config = function()
      vim.cmd [[colorscheme rasmus]]
    end,
    enabled = false,
  },

  {
    'danth/pathfinder.vim',
    enabled = false,
  },

  {
    'Mofiqul/dracula.nvim',
    config = function()
      vim.cmd [[colorscheme dracula]]
    end,
    enabled = false,
  },
  {
    'olimorris/onedarkpro.nvim',
    config = function()
      require('onedarkpro').setup({
        dark_theme = "onedark",
      })
      vim.o.background = "dark"
      require('onedarkpro').load()
    end,
    enabled = false,
  },
}

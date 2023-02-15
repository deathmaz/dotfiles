return {
  'nvim-lua/plenary.nvim',
  'kyazdani42/nvim-web-devicons',
  {
    'ibhagwan/smartyank.nvim',
    config = function()
      require('_smartyank')
    end
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
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('_nvim-tree')
    end
  },

  'andymass/vim-matchup',
  'whiteinge/diffconflicts',
  {
    'deathmaz/fzf-lua-asynctasks',
    config = function()
      require('_fzf-lua-asynctasks')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('_gitsigns')
    end,
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
    'simrat39/rust-tools.nvim',
  },

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require('_project')
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
      require('_lsp-saga')
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
  'ThePrimeagen/harpoon',
  'bfredl/nvim-miniyank',
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
    end
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
  'windwp/nvim-ts-autotag',
  {
    'arthurxavierx/vim-caser'
  },
  {
    'fatih/vim-go',
    build = ':GoUpdateBinaries',
    ft = { 'go' },
    enabled = false,
  },
  {
    'potamides/pantran.nvim',
    cmd = { 'Pantran' }
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('_indent-blankline')
    end
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
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('_tree-sitter')
    end,
    dependencies = {
      {
        'abecodes/tabout.nvim',
        config = function()
          require('_tabout')
        end,
        enabled = false,
      },
      {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require('_nvim-treesitter-context')
        end
      },
    },
  },
  { 'RRethy/nvim-treesitter-endwise' },

  { "folke/neodev.nvim" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "ray-x/lsp_signature.nvim" },
  { "b0o/SchemaStore.nvim" },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require('_lsp-lines')
    end
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
    end
  },
  {
    'nvim-lua/lsp-status.nvim',
    enabled = false,
  },

  {
    'axelvc/template-string.nvim',
    config = function()
      require('_template-string')
    end
  },

  {
    'AndrewRadev/splitjoin.vim',
    config = function()
      require('_splitjoin')
    end
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
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer', -- buffer completions,
      'hrsh7th/cmp-path', -- path completions,
      'hrsh7th/cmp-cmdline', -- cmdline completions,
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-nvim-lua',
    }
  },
  {
    'https://gitlab.com/yorickpeterse/nvim-dd.git',
    config = function()
      require('dd').setup()
    end
  },

  { 'psliwka/vim-dirtytalk', build = ':DirtytalkUpdate' },

  {
    'gbprod/substitute.nvim',
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
  --  'antoinemadec/FixCursorHold.nvim'

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
    'feline-nvim/feline.nvim',
    config = function()
      require('_feline')
    end,
    dependencies = { 'kyazdani42/nvim-web-devicons' }
  },
  'wincent/ferret',
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

  { 'ibhagwan/fzf-lua',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('_fzf-lua')
    end,
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
  'junegunn/vim-easy-align',
  'junegunn/vim-slash',
  'junegunn/vim-emoji',
  {
    'othree/html5.vim',
    enabled = false
  },
  {
    'mattn/emmet-vim',
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
  },
  'kana/vim-textobj-user',
  {
    -- TODO: this one throws error on startup
    'kana/vim-textobj-indent',
    enabled = false,
  },
  {
    'lukas-reineke/headlines.nvim',
    config = function()
      require('headlines').setup()
    end,
    enabled = false,
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

  --  'b3nj5m1n/kommentary'
  --  'JoosepAlviste/nvim-ts-context-commentstring'
  {
    'numToStr/Comment.nvim',
    event = { 'BufWinEnter', 'BufNewFile' },
    config = function()
      require('Comment').setup()
    end,
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        -- TODO: check if this is still working
        -- module = 'ts_context_commentstring',
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
    'Lokaltog/vim-monotone',
    enabled = false,
  },

  {
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

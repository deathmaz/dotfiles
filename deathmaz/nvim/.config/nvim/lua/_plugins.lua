local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost _plugins.lua source <afile> | PackerCompile
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

return packer.startup({
  function(use)
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use {
      'ibhagwan/smartyank.nvim',
      config = function()
        require('_smartyank')
      end
    }

    use {
      'gaoDean/autolist.nvim',
      config = function()
        require('_autolist')
      end
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons',
      },
      config = function()
        require('_nvim-tree')
      end
    }

    use 'andymass/vim-matchup'
    use 'whiteinge/diffconflicts'
    use {
      '~/projects/fzf-lua-asynctasks',
      config = function()
        require('_fzf-lua-asynctasks')
      end,
    }
    use {
      'nvim-treesitter/nvim-treesitter-context',
      requires = { 'nvim-treesitter/nvim-treesitter' },
      config = function()
        require('_nvim-treesitter-context')
      end
    }
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('_gitsigns')
      end,
    }
    use {
      'sindrets/diffview.nvim',
      cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
      config = function()
        require('_diffview')
      end,
    }
    use {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      config = function()
        require('_telescope')
      end,
      disable = true,
    }
    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make',
      disable = true,
    }

    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig",
      config = function()
        require('_navic')
      end
    }

    use {
      'simrat39/rust-tools.nvim',
    }

    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require('_project')
      end,
    }

    use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
        require('_lsp-saga')
      end
    })

    use {
      'pwntester/octo.nvim',
      cmd = 'Octo',
      config = function()
        require('_octo')
      end,
      disable = true,
    }

    use {
      'kwkarlwang/bufresize.nvim',
      module = 'bufresize',
      setup = function()
        vim.api.nvim_create_autocmd('VimResized', {
          callback = function()
            require('bufresize').resize()
          end,
        })
      end,
      disable = true,
    }
    use 'ThePrimeagen/harpoon'
    use 'bfredl/nvim-miniyank'
    use {
      'folke/todo-comments.nvim',
      -- cmd = { 'TodoQuickFix', 'TodoTrouble', 'TodoTelescope' },
      config = function()
        require('_todo-comments')
      end,
    }
    use {
      "rrethy/vim-hexokinase",
      run = "make hexokinase",
      config = function()
        require('_hexokinase')
      end
    }
    use {
      'kevinhwang91/nvim-bqf',
      ft = 'qf',
      config = function()
        require('bqf').setup({
          auto_resize_height = false,
        })
      end,
    }
    use 'windwp/nvim-ts-autotag'
    use {
      'arthurxavierx/vim-caser'
    }
    use {
      'fatih/vim-go',
      run = ':GoUpdateBinaries',
      ft = { 'go' },
      disable = true,
    }
    use {
      'potamides/pantran.nvim',
      cmd = { 'Pantran' }
    }

    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('_indent-blankline')
      end
    }

    --[[ use {
      'lambdalisue/fern.vim',
      branch = 'main',
    }
    use 'lambdalisue/fern-git-status.vim'
    use 'lambdalisue/fern-hijack.vim' ]]
    use {
      'lambdalisue/suda.vim',
      config = function()
        vim.g.suda_smart_edit = true
        vim.g['suda#prompt'] = "Type sudo password: "
      end
    }

    use {
      'dhruvasagar/vim-table-mode',
      cmd = 'TableModeToggle',
    }
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        require('_tree-sitter')
      end,
    }
    use({ 'RRethy/nvim-treesitter-endwise' })

    use { "folke/neodev.nvim" }
    use { "williamboman/mason.nvim" }
    use { "williamboman/mason-lspconfig.nvim" }
    use { "neovim/nvim-lspconfig" }
    use { "ray-x/lsp_signature.nvim" }
    use { "b0o/SchemaStore.nvim" }
    use {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      config = function()
        require('_lsp-lines')
      end
    }
    use {
      "j-hui/fidget.nvim",
      config = function()
        require('_fidget')
      end,
      disable = true,
    }
    use {
      'onsails/lspkind.nvim',
      config = function()
        require('_lspkind')
      end
    }
    use {
      'nvim-lua/lsp-status.nvim',
      disable = true,
    }

    use {
      'axelvc/template-string.nvim',
      config = function()
        require('_template-string')
      end
    }

    use {
      'AndrewRadev/splitjoin.vim',
      config = function()
        require('_splitjoin')
      end
    }

    use {
      'L3MON4D3/LuaSnip',
      config = function()
        require('_luasnip')
      end
    }
    use {
      'rafamadriz/friendly-snippets',
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end
    }
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-emoji"
    use "hrsh7th/cmp-nvim-lua"
    use {
      'https://gitlab.com/yorickpeterse/nvim-dd.git',
      config = function()
        require('dd').setup()
      end
    }
    use { 'saadparwaiz1/cmp_luasnip' }

    use({ 'psliwka/vim-dirtytalk', run = ':DirtytalkUpdate' })

    use({
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
    })

    -- due to https://github.com/neovim/neovim/issues/12587
    -- use 'antoinemadec/FixCursorHold.nvim'

    use {
      'neoclide/coc.nvim',
      branch = 'pum',
      run = 'yarn install --frozen-lockfile',
      disable = true,
    }
    use {
      'antoinemadec/coc-fzf',
      disable = true,
    }

    use {
      'kevinhwang91/nvim-ufo',
      requires = 'kevinhwang91/promise-async',
      config = function()
        require('_ufo')
      end,
      disable = true,
    }
    use {
      'feline-nvim/feline.nvim',
      config = function()
        require('_feline')
      end,
      requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use 'wincent/ferret'
    use {
      'wincent/command-t',
      run = 'cd lua/wincent/commandt/lib && make',
      setup = function()
        vim.g.CommandTPreferredImplementation = 'lua'
      end,
      config = function()
        require('wincent.commandt').setup()
      end,
      disable = true,
    }

    use 'gpanders/editorconfig.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-surround'
    use 'tpope/vim-eunuch'
    use 'tpope/vim-unimpaired'
    use {
      'tpope/vim-rsi'
    }
    use {
      'ron89/thesaurus_query.vim',
      cmd = {
        'Thesaurus',
        'ThesaurusQueryLookupCurrentWord',
        'ThesaurusQueryReplaceCurrentWord',
        'ThesaurusQueryReplace'
      }
    }

    use { 'ibhagwan/fzf-lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('_fzf-lua')
      end,
    }

    use {
      'junegunn/gv.vim',
      cmd = 'GV'
    }
    --[[ use {
      'junegunn/fzf',
      run = function() vim.fn['fzf#install']() end,
    } ]]
    use {
      'junegunn/fzf.vim',
      disable = true,
    }
    use {
      'junegunn/limelight.vim',
      cmd = 'Limelight'
    }
    use 'junegunn/vim-easy-align'
    use 'junegunn/vim-slash'
    use 'junegunn/vim-emoji'
    use {
      'othree/html5.vim',
      disable = true
    }
    use {
      'mattn/emmet-vim',
    }
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('_autopairs')
      end,
      disable = true,
    }

    use {
      'LunarWatcher/auto-pairs',
      config = function()
        require('_vim-autopairs')
      end
    }

    use {
      'mhinz/vim-sayonara',
      cmd = 'Sayonara'
    }
    use 'mattn/webapi-vim'
    use 'wellle/targets.vim'
    use 'elzr/vim-json'
    use 'fladson/vim-kitty'
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app & yarn install',
      ft = 'markdown',
      cmd = 'MarkdownPreview',
    }
    use {
      'dyng/ctrlsf.vim',
      cmd = 'CtrlSF'
    }
    use {
      't9md/vim-choosewin',
      disable = true
    }
    use {
      's1n7ax/nvim-window-picker',
      tag = 'v1.*',
      config = function()
        require('_window-picker')
      end,
    }
    use 'kana/vim-textobj-user'
    use 'kana/vim-textobj-indent'
    use {
      'lukas-reineke/headlines.nvim',
      config = function()
        require('headlines').setup()
      end,
      disable = true,
    }
    use {
      'whatyouhide/vim-textobj-xmlattr',
      ft = { 'html', 'vue', 'blade' }
    }
    use {
      'rhysd/accelerated-jk',
      disable = true,
    }
    use {
      'jwalton512/vim-blade',
      ft = 'blade',
    }

    use {
      'skywind3000/asynctasks.vim',
      config = function()
        require('_asynctasks')
      end,
      event = { 'BufWinEnter', 'BufNewFile' },
      cmd = { 'AsyncTask', 'AsyncTaskMacro', 'AsyncTaskList', 'AsyncTaskEdit' }
    }
    use {
      'skywind3000/asyncrun.vim',
      cmd = { 'AsyncRun', 'AsyncStop' }
    }

    -- use 'b3nj5m1n/kommentary'
    -- use 'JoosepAlviste/nvim-ts-context-commentstring'
    use {
      'numToStr/Comment.nvim',
      event = { 'BufWinEnter', 'BufNewFile' },
      config = function()
        require('Comment').setup()
      end,
      requires = {
        {
          'JoosepAlviste/nvim-ts-context-commentstring',
          module = 'ts_context_commentstring',
        },
      },
    }
    use {
      'abecodes/tabout.nvim',
      config = function()
        require('_tabout')
      end,
      requires = { 'nvim-treesitter/nvim-treesitter' },
      after = { 'nvim-cmp' },
      disable = true,
    }

    use {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      disable = true,
    }

    use {
      'anuvyklack/hydra.nvim',
      requires = 'anuvyklack/keymap-layer.nvim',
      config = function()
        require('_hydra')
      end
    }

    -- Colorschemes
    -- use 'projekt0n/github-nvim-theme'
    -- use 'chriskempson/base16-vim'
    -- use 'crusoexia/vim-monokai'
    use({
      'glepnir/zephyr-nvim',
      requires = {
        'nvim-treesitter/nvim-treesitter',
      },
      config = function()
        require('zephyr')
      end,
      disable = true,
    })
    use {
      'navarasu/onedark.nvim',
      config = function()
        require('onedark').setup({
          style = 'deep'
        })
        require('onedark').load()
      end,
      disable = true,
    }
    use {
      "EdenEast/nightfox.nvim",
      config = function()
        vim.cmd("colorscheme nightfox")
      end,
      disable = true,
    }
    use {
      'tanvirtin/monokai.nvim',
      config = function()
        require('_monokai')
      end,
      disable = true,
    }
    use {
      'folke/tokyonight.nvim',
      config = function()
        vim.cmd [[colorscheme tokyonight]]
      end,
      disable = true,
    }
    use {
      'ishan9299/nvim-solarized-lua',
      config = function()
        vim.cmd('colorscheme solarized-high')
      end,
      disable = true,
    }
    use {
      "catppuccin/nvim",
      as = "catppuccin",
      run = ":lua require('catppuccin').compile()",
      setup = function()
        vim.g.catppuccin_flavour = "macchiato"
      end,
      config = function()
        require('_catppuccin')
      end,
      disable = false,
    }

    use {
      'Lokaltog/vim-monotone',
      disable = false,
    }

    use({
      'cranberry-clockworks/coal.nvim',
    })

    use {
      'kvrohit/rasmus.nvim',
      setup = function()
        -- vim.g.rasmus_variant = "monochrome"
      end,
      config = function()
        vim.cmd [[colorscheme rasmus]]
      end,
      disable = true,
    }

    use {
      'danth/pathfinder.vim',
      disable = true,
    }

    use {
      'Mofiqul/dracula.nvim',
      config = function()
        vim.cmd [[colorscheme dracula]]
      end,
      disable = true,
    }
    use {
      'olimorris/onedarkpro.nvim',
      config = function()
        require('onedarkpro').setup({
          dark_theme = "onedark",
        })
        vim.o.background = "dark"
        require('onedarkpro').load()
      end,
      disable = true,
    }
    -- use 'projekt0n/github-nvim-theme'
    -- use 'iCyMind/NeoSolarized'
    -- use 'lifepillar/vim-solarized8'
    -- use 'zekzekus/menguless'
    -- use 'andreasvc/vim-256noir'
    -- use 'kdheepak/monochrome.nvim'
    -- use 'deathmaz/vim-colors-plain'
    -- use 'pbrisbin/vim-colors-off'
    -- use 'huyvohcmc/atlas.vim'
    -- use 'aditya-azad/candle-grey'

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    max_jobs = 50,
    display = {
      open_cmd = 'silent topleft 80vnew',
      --[[ open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end, ]]
      prompt_border = "rounded", -- Border style of prompt popups.
    },
  },
})

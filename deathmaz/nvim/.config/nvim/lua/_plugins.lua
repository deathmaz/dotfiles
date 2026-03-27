local provider = require('_provider')

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
    "cajames/copy-reference.nvim",
    opts = {}, -- optional configuration
    keys = {
      { "<space>y",  "<cmd>CopyReference file<cr>", mode = { "n", "v" }, desc = "Copy file path" },
      { "<space>yr", "<cmd>CopyReference line<cr>", mode = { "n", "v" }, desc = "Copy file:line reference" },
    },
  },
  {
    'jakewvincent/mkdnflow.nvim',
    cond = not vim.g.vscode,
    config = function(_, opts)
      -- Workaround: mkdnflow's activate() calls `doautocmd FileType` which
      -- re-triggers treesitter foldexpr evaluation mid-parse, sometimes
      -- collapsing all folds. Defer foldlevel reset to after all processing.
      -- Must be registered BEFORE setup(), which fires doautocmd FileType.
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'markdown',
        callback = function()
          vim.schedule(function()
            vim.wo.foldlevel = 99
          end)
        end,
      })
      require('mkdnflow').setup(opts)
    end,
    opts = {
      modules = {
        bib = true,
        buffers = true,
        conceal = true,
        cursor = true,
        folds = false,
        foldtext = false,
        links = true,
        lists = true,
        maps = true,
        paths = true,
        tables = true,
        templates = true,
        to_do = true,
        yaml = false,
        completion = false,
      },
      mappings = {
        -- conflicts with coc.nvim
        MkdnNextLink = false,
        MkdnPrevLink = false,
        MkdnTableNextCell = false,
        MkdnTablePrevCell = false,

        MkdnEnter = { { 'n', 'v', 'i' }, '<C-\\>' },
        MkdnFoldSection = false,
        MkdnUnfoldSection = false,
        MkdnToggleToDo = { { 'n', 'v', 'i' }, '<M-f>' },
        MkdnDestroyLink = { { 'n', 'v' }, '<M-d>' },
      },
      perspective = {
        priority = 'current',
      },
      to_do = {
        statuses = {
          not_started = { marker = ' ', ... },
          in_progress = { marker = '-', ... },
          complete = { marker = { 'x' }, ... },
        },
      },
    },
    enabled = true,
  },

  {
    "NickvanDyke/opencode.nvim",
    enabled = false,
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = {
          enabled = "kitty",
        }
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      -- vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
        { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
        { expr = true, desc = "Add range to opencode" })
      vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
        { expr = true, desc = "Add line to opencode" })

      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
        { desc = "opencode half page up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
        { desc = "opencode half page down" })

      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
      -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    cond = not vim.g.vscode,
    ft = {
      "markdown",
      "codecompanion",
    },
    opts = {
      render_modes = true, -- Render in ALL modes
      sign = {
        enabled = false,   -- Turn off in the status column
      },
    },
  },

  {
    enabled = false,
    cond = not vim.g.vscode,
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },

  {
    "olimorris/codecompanion.nvim",
    cond = not vim.g.vscode,
    opts = {
      interactions = {
        chat = {
          -- adapter = 'opencode',
          adapter = {
            name = 'copilot',
            -- model = "gpt-5",
            model = "claude-sonnet-4",
            -- model = "claude-sonnet-4",
          },
          opts = {
            completion_provider = provider.is_coc() and "coc" or "default", -- blink|cmp|coc|default
          }
        },
        inline = {
          adapter = {
            name = 'copilot',
            -- model = "gpt-5",
            -- model = "claude-sonnet-4-5-20250929",
            model = "claude-sonnet-4",
          },
          opts = {
            completion_provider = provider.is_coc() and "coc" or "default", -- blink|cmp|coc|default
          }
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    'stevearc/oil.nvim',
    cond = not vim.g.vscode,
    opts = {},
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("oil").setup({
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
      })
      vim.keymap.set("n", "<C-->", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
    end,
    lazy = false,
  },

  {
    'SidOfc/mkdx',
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    init = function()
      vim.g.csv_default_delim = ';'
      vim.g.csv_delim = ';'
    end,
    enabled = true,
  },

  {
    "chrisgrieser/nvim-early-retirement",
    cond = not vim.g.vscode,
    config = true,
    event = "VeryLazy",
    opts = {
      minimumBufferNum = 5,
    },
    enabled = false,
  },

  {
    "zbirenbaum/copilot.lua",
    cond = not vim.g.vscode,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require('_copilot')
    end,
    enabled = false,
  },

  {
    'gaoDean/autolist.nvim',
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
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
    enabled = true,
  },
  {
    'whiteinge/diffconflicts',
    cond = not vim.g.vscode,
  },
  {
    'deathmaz/fzf-lua-asynctasks',
    cond = not vim.g.vscode,
    dir = "~/projects/fzf-lua-asynctasks",
    dependencies = { 'ibhagwan/fzf-lua' },
    config = function()
      require('_fzf-lua-asynctasks')
    end,
    event = 'VeryLazy',
  },
  {
    'lewis6991/gitsigns.nvim',
    cond = not vim.g.vscode,
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('_gitsigns')
    end,
    event = 'VeryLazy',
  },
  {
    'sindrets/diffview.nvim',
    cond = not vim.g.vscode,
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    config = function()
      require('_diffview')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cond = not vim.g.vscode,
    branch = '0.1.x',
    config = function()
      require('_telescope')
    end,
    enabled = false,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    cond = not vim.g.vscode,
    build = 'make',
    enabled = false,
  },

  {
    "SmiteshP/nvim-navic",
    cond = not vim.g.vscode,
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require('_navic')
    end,
    enabled = false,
  },

  {
    "ahmedkhalf/project.nvim",
    cond = not vim.g.vscode,
    config = function()
      require('_project')
    end,
  },

  {
    'pwntester/octo.nvim',
    cond = not vim.g.vscode,
    cmd = 'Octo',
    config = function()
      require('_octo')
    end,
    enabled = false,
  },

  {
    'kwkarlwang/bufresize.nvim',
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    event = 'VeryLazy',
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        }
      });
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<C-1>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-2>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-3>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-4>", function() harpoon:list():select(4) end)
    end,
    enabled = true,
  },
  {
    'bfredl/nvim-miniyank',
    event = 'VeryLazy'
  },
  {
    "folke/zen-mode.nvim",
    cond = not vim.g.vscode,
    opts = {
      window = {
        width = 100,
        number = false,
        relativenumber = false,
      },
      plugins = {
        twilight = {
          enabled = false,
        },
      },
      on_open = function(win)
        vim.opt_local.textwidth = 0
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.wrap = true
        vim.wo[win].winbar = vim.o.winbar
      end,
    }
  },
  {
    "folke/twilight.nvim",
    cond = not vim.g.vscode,
    opts = {}
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
    cond = not vim.g.vscode,
    build = "make hexokinase",
    config = function()
      require('_hexokinase')
    end,
    event = 'VeryLazy'
  },
  {
    'kevinhwang91/nvim-bqf',
    cond = not vim.g.vscode,
    -- TODO: doesn't work with newest treesitter changes
    -- potential fix https://github.com/kevinhwang91/nvim-bqf/pull/162
    enabled = true,
    ft = 'qf',
    config = function()
      require('bqf').setup({
        auto_resize_height = true,
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
    cond = not vim.g.vscode,
    build = ':GoUpdateBinaries',
    ft = { 'go' },
    enabled = false,
  },
  {
    'potamides/pantran.nvim',
    cond = not vim.g.vscode,
    cmd = { 'Pantran' },
    enabled = false,
  },

  {
    "dnlhc/glance.nvim",
    cond = not vim.g.vscode,
    cmd = "Glance",
    config = true,
    enabled = false,
  },
  {
    "danymat/neogen",
    cond = not vim.g.vscode,
    cmd = { 'Neogen' },
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    config = function()
      vim.g.suda_smart_edit = true
      vim.g['suda#prompt'] = "Type sudo password: "
    end
  },

  {
    'dhruvasagar/vim-table-mode',
    cond = not vim.g.vscode,
    cmd = 'TableModeToggle',
  },
  {
    "MTDL9/vim-log-highlighting",
    cond = not vim.g.vscode,
    ft = "log",
  },
  {
    'windwp/nvim-ts-autotag',
    cond = not vim.g.vscode,
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true,         -- Auto close tags
          enable_rename = true,        -- Auto rename pairs of tags
          enable_close_on_slash = true -- Auto close on trailing </
        },
      })
    end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    cond = not vim.g.vscode,
    build = ':TSUpdate',
    branch = 'main',
    lazy = false,
    config = function()
      require('_tree-sitter')
    end,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        enabled = provider.is_native(),
      },
      {
        'nvim-treesitter/nvim-treesitter-context',
        config = function()
          require('_nvim-treesitter-context')
        end,
        enabled = false,
      },
      {
        'RRethy/nvim-treesitter-endwise',
        -- TODO: broken with nvim-treesitter `main` branch https://github.com/RRethy/nvim-treesitter-endwise/issues/27
        enabled = false,
      },
      {
        'axelvc/template-string.nvim',
        config = function()
          require('_template-string')
        end,
      },
    },
  },
  {
    'abecodes/tabout.nvim',
    cond = not vim.g.vscode,
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
    config = function()
      require('_tabout')
    end,
    enabled = false,
  },

  -- Native LSP stack
  {
    "neovim/nvim-lspconfig",
    cond = not vim.g.vscode and provider.is_native(),
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "b0o/SchemaStore.nvim",
    },
    config = function()
      require("_native-lsp")
    end,
  },
  {
    "williamboman/mason.nvim",
    cond = not vim.g.vscode and provider.is_native(),
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    cond = not vim.g.vscode and provider.is_native(),
    opts = {},
  },
  {
    "L3MON4D3/LuaSnip",
    cond = not vim.g.vscode and provider.is_native(),
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
    end,
  },
  {
    "saghen/blink.cmp",
    cond = not vim.g.vscode and provider.is_native(),
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("_native-cmp")
    end,
  },
  -- TODO: set up formatting
  {
    "stevearc/conform.nvim",
    cond = not vim.g.vscode and provider.is_native(),
    event = "BufWritePre",
    config = function()
      require("_native-format")
    end,
    enabled = false,
  },
  {
    "j-hui/fidget.nvim",
    cond = not vim.g.vscode and provider.is_native(),
    opts = {},
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
    cond = not vim.g.vscode and provider.is_coc(),
    branch = 'master',
    build = 'npm ci',
    enabled = true,
    config = function()
      require('_coc')
    end,
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        enabled = true,
      },
      {
        'antoinemadec/coc-fzf',
        enabled = false,
      },
      {
        dir = '~/projects/coc-volar',
        build = 'yarn install --frozen-lockfile && yarn build',
      }
    },
  },

  {
    dir = '~/projects/joplin-nvim',
    opts = {},
    config = function ()
      vim.keymap.set("n", "\\j", "<cmd>Joplin<cr>", { desc = "Browse joplin notes and todos" })
    end
  },
  {
    'kevinhwang91/nvim-ufo',
    cond = not vim.g.vscode,
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      require('_ufo')
    end,
    enabled = false,
  },
  {
    'freddiehaddad/feline.nvim',
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    event = 'VeryLazy',
  },
  {
    'wincent/command-t',
    cond = not vim.g.vscode,
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
    'tpope/vim-obsession',
    cond = not vim.g.vscode,
    init = function()
      local sessions_dir = '~/.config/vim-sessions'
      vim.keymap.set("n", "<space>aS", ":Obsession " .. sessions_dir .. "/*<C-D><BS>")
      vim.keymap.set("n", "<space>as", ":so " .. sessions_dir .. "/*<C-D><BS>")
    end
  },
  {
    'tpope/vim-rsi'
  },
  {
    'ron89/thesaurus_query.vim',
    cond = not vim.g.vscode,
    cmd = {
      'Thesaurus',
      'ThesaurusQueryLookupCurrentWord',
      'ThesaurusQueryReplaceCurrentWord',
      'ThesaurusQueryReplace'
    }
  },

  {
    'ibhagwan/fzf-lua',
    cond = not vim.g.vscode,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('_fzf-lua')
    end,
    event = 'VeryLazy',
  },
  {
    'chaoren/vim-wordmotion',
    cond = not vim.g.vscode,
    enabled = false,
  },

  {
    'junegunn/gv.vim',
    cond = not vim.g.vscode,
    cmd = 'GV'
  },
  --[[  {
  'junegunn/fzf',
  build = function() vim.fn['fzf#install']() end,
  } ]]
  {
    'junegunn/fzf.vim',
    cond = not vim.g.vscode,
    enabled = false,
  },
  {
    'junegunn/vim-easy-align',
    cond = not vim.g.vscode,
    event = 'VeryLazy',
  },
  {
    'junegunn/vim-slash',
    enabled = false,
  },
  {
    'junegunn/vim-emoji',
    cond = not vim.g.vscode,
  },
  {
    'othree/html5.vim',
    cond = not vim.g.vscode,
    enabled = false
  },
  {
    'mattn/emmet-vim',
    cond = not vim.g.vscode,
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
    event = "InsertEnter",
    cond = not vim.g.vscode,
    config = function()
      require('_autopairs')
    end,
    enabled = true,
  },

  {
    'LunarWatcher/auto-pairs',
    cond = not vim.g.vscode,
    lazy = false,
    config = function()
      require('_vim-autopairs')
    end,
    enabled = false,
  },

  {
    'mhinz/vim-sayonara',
    cmd = 'Sayonara'
  },
  'mattn/webapi-vim',
  'wellle/targets.vim',
  {
    'elzr/vim-json',
    cond = not vim.g.vscode,
  },
  {
    'fladson/vim-kitty',
    cond = not vim.g.vscode,
  },
  {
    'iamcco/markdown-preview.nvim',
    cond = not vim.g.vscode,
    build = 'cd app & yarn install',
    ft = 'markdown',
    cmd = 'MarkdownPreview',
  },
  {
    'dyng/ctrlsf.vim',
    cond = not vim.g.vscode,
    cmd = 'CtrlSF'
  },
  {
    't9md/vim-choosewin',
    cond = not vim.g.vscode,
    enabled = false
  },
  {
    's1n7ax/nvim-window-picker',
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    ft = "markdown",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      markdown = {
        fat_headlines = false,
      },
    },
    enabled = false,
  },
  {
    'whatyouhide/vim-textobj-xmlattr',
    cond = not vim.g.vscode,
    ft = { 'html', 'vue', 'blade' }
  },
  {
    'rhysd/accelerated-jk',
    cond = not vim.g.vscode,
    enabled = false,
  },
  {
    'jwalton512/vim-blade',
    cond = not vim.g.vscode,
    ft = 'blade',
  },

  {
    'skywind3000/asynctasks.vim',
    cond = not vim.g.vscode,
    config = function()
      require('_asynctasks')
    end,
    event = { 'BufWinEnter', 'BufNewFile' },
    cmd = { 'AsyncTask', 'AsyncTaskMacro', 'AsyncTaskList', 'AsyncTaskEdit' }
  },
  {
    'skywind3000/asyncrun.vim',
    cond = not vim.g.vscode,
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
        config = function()
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
    cond = not vim.g.vscode,
    dependencies = "nvim-treesitter/nvim-treesitter",
    enabled = false,
  },

  {
    "HakonHarnes/img-clip.nvim",
    cond = not vim.g.vscode,
    event = "VeryLazy",
    opts = {
      filetypes = {
        markdown = {
          relative_to_current_file = true,
          dir_path = function()
            return "asset_" .. vim.fn.expand("%:t:r")
          end,
        },
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
  {
    'qadzek/link.vim',
    cond = not vim.g.vscode,
    ft = {
      "markdown",
      "mail",
    },
  },

  -- Colorschemes
  --  'projekt0n/github-nvim-theme'
  --  'chriskempson/base16-vim'
  --  'crusoexia/vim-monokai'
  {
    'crusoexia/vim-monokai',
    cond = not vim.g.vscode,
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme monokai')
    end,
  },
  {
    'RRethy/base16-nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme base16-tomorrow-night')
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    enabled = false,
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- require('github-theme').setup({ })

      vim.cmd('colorscheme github_dark_dimmed')
    end,
  },
  {
    enabled = false,
    cond = not vim.g.vscode,
    "idr4n/github-monochrome.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("github-monochrome-dark")
    end
  },
  {
    'glepnir/zephyr-nvim',
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    config = function()
      vim.cmd("colorscheme nightfox")
    end,
    enabled = false,
  },
  {
    'tanvirtin/monokai.nvim',
    cond = not vim.g.vscode,
    lazy = false,
    priority = 1000,
    config = function()
      require('_monokai')
    end,
    enabled = false,
  },
  {
    'folke/tokyonight.nvim',
    cond = not vim.g.vscode,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
    enabled = false,
  },
  {
    'ishan9299/nvim-solarized-lua',
    cond = not vim.g.vscode,
    config = function()
      vim.cmd('colorscheme solarized-high')
    end,
    enabled = false,
  },
  {
    enabled = false,
    cond = not vim.g.vscode,
    'rktjmp/lush.nvim',
  },
  {
    enabled = false,
    cond = not vim.g.vscode,
    'metalelf0/jellybeans-nvim',
    priority = 1000,
    lazy = false,
    init = function()
      vim.cmd.colorscheme("jellybeans-nvim")
    end
  },
  {
    enabled = false,
    cond = not vim.g.vscode,
    "wtfox/jellybeans.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("jellybeans").setup({
        italics = false,
      })
      vim.cmd.colorscheme("jellybeans")
    end,
  },
  {
    enabled = false,
    cond = not vim.g.vscode,
    "https://git.sr.ht/~p00f/alabaster.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme alabaster]]

      vim.cmd([[let &t_Cs = "\e[4:3m"]])
      vim.cmd([[let &t_Ce = "\e[4:0m"]])

      vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true })
      vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true })
      vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { undercurl = true })
      vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { undercurl = true })
    end,

  },
  {
    enabled = true,
    cond = not vim.g.vscode,
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
    enabled = true,
    cond = not vim.g.vscode,
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    config = function()
      require('_lualine')
    end
  },
  {
    'Lokaltog/vim-monotone',
    cond = not vim.g.vscode,
    enabled = false,
  },

  {
    enabled = false,
    cond = not vim.g.vscode,
    'cranberry-clockworks/coal.nvim',
    config = function()
      require('coal').setup()
    end
  },

  {
    'kvrohit/rasmus.nvim',
    cond = not vim.g.vscode,
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
    cond = not vim.g.vscode,
    enabled = false,
  },

  {
    'Mofiqul/dracula.nvim',
    cond = not vim.g.vscode,
    config = function()
      vim.cmd [[colorscheme dracula]]
    end,
    enabled = false,
  },
  {
    'olimorris/onedarkpro.nvim',
    cond = not vim.g.vscode,
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

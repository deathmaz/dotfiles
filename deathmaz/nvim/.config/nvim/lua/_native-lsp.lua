local icons = require("_icons")
local fzf_lua = require("fzf-lua")

-- Diagnostics configuration
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.vscode.Error,
      [vim.diagnostic.severity.WARN] = icons.vscode.Warning,
      [vim.diagnostic.severity.INFO] = icons.vscode.Info,
      [vim.diagnostic.severity.HINT] = icons.vscode.Lightbulb,
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "if_many",
    header = "",
    prefix = "",
  },
})


-- Keybindings on LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("NativeLspKeymaps", {}),
  callback = function(ev)
    local buf = ev.buf
    local opts = { buffer = buf, silent = true }

    -- Navigation (via fzf-lua)
    vim.keymap.set("n", "gd", function()
      fzf_lua.lsp_definitions({ jump1 = true })
    end, opts)
    vim.keymap.set("n", "gy", function()
      fzf_lua.lsp_typedefs({ jump1 = true })
    end, opts)
    vim.keymap.set("n", "gI", function()
      fzf_lua.lsp_implementations()
    end, opts)
    vim.keymap.set("n", "gr", function()
      fzf_lua.lsp_references({ ignore_current_line = true })
    end, opts)

    -- Hover & documentation
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, opts)

    -- Diagnostics
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({
        count = -1,
        on_jump = function()
          vim.diagnostic.open_float({ border = "rounded" })
        end,
      })
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({
        count = 1,
        on_jump = function()
          vim.diagnostic.open_float({ border = "rounded" })
        end,
      })
    end, opts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "\\d", function()
      fzf_lua.diagnostics_document()
    end, opts)

    -- Symbols
    vim.keymap.set("n", "\\s", function()
      fzf_lua.lsp_document_symbols()
    end, opts)
    vim.keymap.set("n", "\\w", function()
      fzf_lua.lsp_live_workspace_symbols()
    end, opts)

    -- Rename
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.rename, opts)

    -- Code actions (via fzf-lua)
    vim.keymap.set({ "n", "x" }, "<M-a>", function()
      fzf_lua.lsp_code_actions()
    end, opts)
    vim.keymap.set("n", "<leader>ac", function()
      fzf_lua.lsp_code_actions()
    end, opts)
    vim.keymap.set("n", "<leader>as", function()
      fzf_lua.lsp_code_actions({ context = { only = { "source" } } })
    end, opts)
    vim.keymap.set("n", "<leader>re", function()
      fzf_lua.lsp_code_actions({ context = { only = { "refactor" } } })
    end, opts)
    vim.keymap.set({ "n", "x" }, "<leader>r", function()
      fzf_lua.lsp_code_actions({ context = { only = { "refactor" } } })
    end, opts)

    -- Code lens
    vim.keymap.set("n", "<leader>cl", vim.lsp.codelens.run, opts)

    -- TODO: inlay hints disabled — causes "Invalid 'col': out of range" with vue_ls
    -- Track: https://github.com/neovim/neovim/issues/36318
    -- local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- if client and client.server_capabilities.inlayHintProvider then
    --   vim.lsp.inlay_hint.enable(true, { bufnr = buf })
    -- end
  end,
})

-- TODO: set up formatting (conform.nvim + eslint fix-on-save)

vim.api.nvim_create_user_command("OR", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" }, diagnostics = {} },
    apply = true,
  })
end, {})

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls",
    "eslint",
    "cssls",
    "html",
    "jsonls",
    "yamlls",
    "lua_ls",
    "bashls",
    "tailwindcss",
    "intelephense",
    "astro",
    "emmet_ls",
    "vue_ls",
  },
  automatic_enable = true,
})

-- Server configurations via vim.lsp.config
local blink_ok, blink = pcall(require, "blink.cmp")
local capabilities = blink_ok and blink.get_lsp_capabilities() or {}

-- Default config for all servers
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Server-specific configs
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("jsonls", {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
})

vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = require("schemastore").yaml.schemas(),
    },
  },
})

-- ts_ls needs @vue/typescript-plugin to handle Vue files in hybrid mode
-- See: https://github.com/vuejs/language-tools/discussions/5619
local vue_language_server_path
do
  local path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
  if vim.uv.fs_stat(path) then
    vue_language_server_path = path
  end
end

vim.lsp.config("ts_ls", {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "none",
        includeInlayFunctionParameterTypeHints = false,
        includeInlayVariableTypeHints = false,
        includeInlayPropertyDeclarationTypeHints = false,
        includeInlayFunctionLikeReturnTypeHints = false,
        includeInlayEnumMemberValueHints = false,
      },
    },
  },
  init_options = {
    preferences = {
      importModuleSpecifierPreference = "relative",
    },
    plugins = vue_language_server_path and {
      {
        name = "@vue/typescript-plugin",
        location = vue_language_server_path,
        languages = { "vue" },
      },
    } or {},
  },
})

vim.lsp.config("eslint", {
  settings = {
    run = "onSave",
  },
})



vim.lsp.config("vue_ls", {
  settings = {
    vue = {
      inlayHints = {
        missingProps = true,
        inlineHandlerLeading = true,
        optionsWrapper = true,
      },
      hover = {
        rich = false,
      },
    },
  },
})

vim.lsp.config("tailwindcss", {
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
})

vim.lsp.config("cssls", {
  settings = {
    css = { lint = { unknownAtRules = "ignore" } },
    scss = { lint = { unknownAtRules = "ignore" } },
  },
})

vim.lsp.config("emmet_ls", {
  filetypes = { "html", "css", "scss", "vue", "astro" },
})

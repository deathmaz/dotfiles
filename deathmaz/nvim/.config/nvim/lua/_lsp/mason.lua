local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "cssls",
  -- "cssmodules_ls",
  "emmet_ls",
  "html",
  "jsonls",
  "lua_ls",
  -- "tsserver",
  "yamlls",
  "bashls",
  "volar",
  "eslint",
  "stylelint_lsp",
  "gopls",
  "rust_analyzer",
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local ok, neodev = pcall(require, "neodev")
if ok then
  neodev.setup({})
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  server = vim.split(server, "@")[1]

  opts = {
    on_attach = require("_lsp.handlers").on_attach,
    capabilities = require("_lsp.handlers").capabilities,
  }

  if server == "jsonls" then
    local jsonls_opts = require "_lsp.settings.jsonls"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "volar" then
    local jsonls_opts = require "_lsp.settings.volar"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server == "stylelint_lsp" then
    local jsonls_opts = require "_lsp.settings.stylelint-lsp"
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  --[[ if server == "yamlls" then
    local yamlls_opts = require "user.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end ]]

  --[[ if server == "sumneko_lua" then
    local sumneko_opts = require "_lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end ]]

  --[[ if server == "tsserver" then
    local tsserver_opts = require "user.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end ]]

  --[[ if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end ]]

  --[[ if server == "solc" then
    local solc_opts = require "user.lsp.settings.solc"
    opts = vim.tbl_deep_extend("force", solc_opts, opts)
  end]]

  --[[ if server == "emmet_ls" then
    local emmet_ls_opts = require "user.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end ]]

  --[[ if server == "zk" then
    local zk_opts = require "user.lsp.settings.zk"
    opts = vim.tbl_deep_extend("force", zk_opts, opts)
  end ]]

  --[[ if server == "jdtls" then
    goto continue
  end ]]

  if server == "rust_analyzer" then
    -- local rust_opts = require "user.lsp.settings.rust"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup({
      server = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
      }
    })
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end

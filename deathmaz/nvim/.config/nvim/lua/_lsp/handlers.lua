local M = {}

local lsp_status = require('_lsp-status')
lsp_status.init()

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

-- needed for https://github.com/kevinhwang91/nvim-ufo
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

M.capabilities = lsp_status.update_capabilities(M.capabilities)

M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
  local icons = require "_icons"
  local signs = {

    { name = "DiagnosticSignError", text = icons.vscode.Error },
    { name = "DiagnosticSignWarn", text = icons.vscode.Warning },
    { name = "DiagnosticSignHint", text = icons.vscode.Lightbulb },
    { name = "DiagnosticSignInfo", text = icons.vscode.Info },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_lines = false,
    virtual_text = false,
    -- virtual_text = {
    --   -- spacing = 7,
    --   -- update_in_insert = false,
    --   -- severity_sort = true,
    --   -- prefix = "<-",
    --   prefix = " ●",
    --   source = "if_many", -- Or "always"
    --   -- format = function(diag)
    --   --   return diag.message .. "blah"
    --   -- end,
    -- },

    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      -- border = {"▄","▄","▄","█","▀","▀","▀","█"},
      source = "if_many", -- Or "always"
      header = "",
      prefix = "",
      -- width = 40,
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_highlight_document(client)
  -- if client.server_capabilities.document_highlight then
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
  -- end
end

local function attach_navic(client, bufnr)
  vim.g.navic_silence = true
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end
  navic.attach(client, bufnr)
end

local function lsp_keymaps(bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local fzf_lua_ok, fzf_lua = pcall(require, 'fzf-lua')
  if fzf_lua_ok then
    vim.keymap.set("n", "gd", function()
      fzf_lua.lsp_definitions({
        jump_to_single_result = true,
      })
    end, bufopts)
    vim.keymap.set("n", "\\s", function()
      fzf_lua.lsp_document_symbols()
    end, bufopts)
    vim.keymap.set("n", "\\w", function()
      fzf_lua.lsp_live_workspace_symbols()
    end, bufopts)
    vim.keymap.set("n", "gI", function()
      fzf_lua.lsp_implementations()
    end, bufopts)
    vim.keymap.set("n", "gr", function()
      fzf_lua.lsp_references({
        ignore_current_line = true
      })
    end, bufopts)
    vim.keymap.set("n", "\\d", function()
      fzf_lua.diagnostics_document()
    end, bufopts)
    vim.keymap.set("n", "<M-a>", function()
      fzf_lua.lsp_code_actions()
    end, bufopts)
  end

  -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
  vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format({ async = false })' ]]
  -- vim.keymap.set("n", "gS", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
  -- vim.keymap.set("n", "<M-f>", "<cmd>Format<cr>", bufopts)
  -- vim.keymap.set("n", "<M-a>", "<cmd>lua vim.lsp.buf.code_action()<cr>", bufopts)
  -- vim.keymap.set("n", "<M-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
  vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
  -- vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
  -- vim.keymap.set("n", "\\d", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
  vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', bufopts)
  vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', bufopts)
  -- vim.keymap.set("n", "\\d", "<cmd>lua vim.diagnostic.setloclist()<CR>", bufopts)
end


M.on_attach = function(client, bufnr)
  lsp_status.attach(client)
  lsp_keymaps(bufnr)
  -- lsp_highlight_document(client)
  attach_navic(client, bufnr)

  --[[ if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint(bufnr, true)
  end ]]
end

function M.enable_format_on_save()
  vim.cmd [[
    augroup format_on_save
      autocmd! 
      " autocmd BufWritePre * lua vim.lsp.buf.format({ async = true }) 
      autocmd BufWritePre *.rs,*.go lua vim.lsp.buf.format() 
      autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js,*.vue EslintFixAll
    augroup end
  ]]
  -- vim.notify "Enabled format on save"
end

function M.disable_format_on_save()
  M.remove_augroup "format_on_save"
  vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
  if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.remove_augroup(name)
  if vim.fn.exists("#" .. name) == 1 then
    vim.cmd("au! " .. name)
  end
end

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("_lsp.handlers").toggle_format_on_save()' ]]
M.enable_format_on_save()

return M

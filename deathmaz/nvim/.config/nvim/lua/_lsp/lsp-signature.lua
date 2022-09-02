local status_ok, signature = pcall(require, "lsp_signature")
if not status_ok then
  return
end

local icons = require "_icons"

local cfg = {
  floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
  floating_window_above_cur_line = false, -- try to place the floating above the current line when possible Note:
  hint_prefix = icons.vscode.Eye .. " ", -- Panda for parameter
  hint_scheme = "Comment",
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
  toggle_key = '<M-x>', -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- recommanded:
signature.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
-- require("lsp_signature").on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
signature.on_attach(cfg) -- no need to specify bufnr if you don't use toggle_key

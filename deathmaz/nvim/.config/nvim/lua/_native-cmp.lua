local blink_ok, blink = pcall(require, "blink.cmp")
if not blink_ok then
  return
end

blink.setup({
  keymap = {
    preset = "none",
    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<C-space>"] = { "show" },
    ["<C-e>"] = { "cancel", "fallback" },
    ["<M-f>"] = { "scroll_documentation_down", "fallback" },
    ["<M-b>"] = { "scroll_documentation_up", "fallback" },
  },

  completion = {
    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = "rounded",
      },
    },
    menu = {
      border = "rounded",
    },
    ghost_text = {
      enabled = true,
    },
  },

  signature = {
    enabled = true,
    window = {
      border = "rounded",
    },
  },

  snippets = {
    preset = "luasnip",
  },

  sources = {
    default = { "lsp", "snippets", "buffer", "path" },
    providers = {
      buffer = {
        min_keyword_length = 3,
      },
    },
  },

  appearance = {
    nerd_font_variant = "mono",
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
})

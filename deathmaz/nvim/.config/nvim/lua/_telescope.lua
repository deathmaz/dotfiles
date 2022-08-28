local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end

local actions = require "telescope.actions"
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

telescope.setup {
  defaults = {
    selection_caret = " ",
    layout_config = { width = 0.95 },
    path_display = {
      truncate = 3
    },
    -- see https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#ripgrep-remove-indentation
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    }
  },
  mappings = {
    i = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,

      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,

      ["<C-b>"] = actions.results_scrolling_up,
      ["<C-f>"] = actions.results_scrolling_down,

      ["<C-c>"] = actions.close,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,

      ["<CR>"] = actions.select_default,
      ["<C-s>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,

      ["<c-d>"] = actions.delete_buffer,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      ["<C-l>"] = actions.complete_tag,
      ["<C-h>"] = actions.which_key, -- keys from pressing <C-h>
      ["<esc>"] = actions.close,
    },

    n = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
      ["<esc>"] = actions.close,
      ["<CR>"] = actions.select_default,
      ["<C-x>"] = actions.select_horizontal,
      ["<C-v>"] = actions.select_vertical,
      ["<C-t>"] = actions.select_tab,
      ["<C-b>"] = actions.results_scrolling_up,
      ["<C-f>"] = actions.results_scrolling_down,

      ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
      ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
      ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

      ["j"] = actions.move_selection_next,
      ["k"] = actions.move_selection_previous,
      ["H"] = actions.move_to_top,
      ["M"] = actions.move_to_middle,
      ["L"] = actions.move_to_bottom,
      ["q"] = actions.close,
      ["dd"] = actions.delete_buffer,
      ["s"] = actions.select_horizontal,
      ["v"] = actions.select_vertical,
      ["t"] = actions.select_tab,

      ["<Down>"] = actions.move_selection_next,
      ["<Up>"] = actions.move_selection_previous,
      ["gg"] = actions.move_to_top,
      ["G"] = actions.move_to_bottom,

      ["<C-u>"] = actions.preview_scrolling_up,
      ["<C-d>"] = actions.preview_scrolling_down,

      ["<PageUp>"] = actions.results_scrolling_up,
      ["<PageDown>"] = actions.results_scrolling_down,

      ["?"] = actions.which_key,
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  }
}

telescope.load_extension('fzf')

-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>v", "<cmd>Telescope buffers<cr>", opts)
-- keymap("n", "<leader>ss", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
-- keymap("n", "<leader>L", "<cmd>Telescope live_grep<cr>", opts)
-- keymap("n", "<leader>ag", "<cmd>Telescope grep_string<cr>", opts)
-- keymap("n", "\\f", "<cmd>Telescope git_status<cr>", opts)
-- keymap("n", "\\b", "<cmd>Telescope git_branches<cr>", opts)

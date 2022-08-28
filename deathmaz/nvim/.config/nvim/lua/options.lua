vim.opt.history = 700
vim.opt.mousefocus = true
-- vim.o.cmdheight = 0
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 10
vim.opt.tags:append({ './.tags' })
vim.opt.inccommand = 'split'
vim.opt.diffopt = {
  'iwhite',
  'vertical',
  'filler',
  'internal',
  'algorithm:histogram',
  'indent-heuristic'
}

-- emoji is true by default but makes (n)vim treat all emoji as double width
-- which breaks rendering so we turn this off.
-- CREDIT: https://www.youtube.com/watch?v=F91VWOelFNE
vim.opt.emoji = false

vim.opt.scrolloff = 7
vim.opt.wildignore:append({
  '.git',
  '.hg',
  '.svn',
  '*.pyc',
  '*.o',
  '*.DS_Store',
  '**/node_modules/**',
})
vim.opt.backspace = {
  'eol',
  'start',
  'indent',
}
vim.opt.whichwrap = "<,>,h,l"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.magic = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number,line'

-- https://www.johnhawthorn.com/2012/09/vi-escape-delays/
vim.opt.timeoutlen = 500
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 250

vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.pastetoggle = "<F2>"
vim.opt.switchbuf = { 'useopen', 'uselast' }
vim.opt.showtabline = 0
vim.opt.laststatus = 3
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.fillchars = {
  diff      = '╱',
  vert      = '│',
  foldopen  = '▾',
  -- foldsep = '│',
  foldclose = '▸',
  eob       = ' ',
  fold      = ' ',
  -- foldopen = '',
  foldsep   = ' ',
  -- foldclose = '›',
}
vim.opt.list = true
vim.opt.listchars = {
  eol = '¬',
  tab = '--›',
  extends = '›', -- Alternatives: … »
  precedes = '‹', -- Alternatives: … «
  trail = '•', -- BULLET (U+2022, UTF-8: E2 80 A2)
}

vim.opt.wrap = false
vim.opt.colorcolumn = ""
vim.opt.signcolumn = "yes"
vim.opt.linebreak = true
vim.opt.synmaxcol = 1024 -- don't syntax highlight long lines
vim.opt.number = true
vim.opt.relativenumber = true

-- vim.opt.foldmethod = "marker"
-- vim.opt.foldtext = "v:lua.require'_folds'.folds()"
-- vim.opt.foldopen = vim.opt.foldopen + 'search'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.foldlevelstart = 99

-- vim.wo.foldcolumn = '1'
-- vim.wo.foldlevel = 99
-- vim.wo.foldenable = true

vim.opt.pumblend = 10

vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2"
vim.wo.showbreak = "↪ " -- '…', '↳ ', '→','↪ '

vim.opt.swapfile = false

vim.opt.fileformats = { 'unix', 'dos', 'mac' }
vim.opt.spelloptions = 'camel'
vim.opt.spellcapcheck = '' -- don't check for capital letters at start of sentence
vim.opt.spellsuggest:prepend({ 12 })
vim.opt.spelllang:append('programming')

vim.g.markdown_fenced_languages = {
  'vim',
  'lua',
  'js=javascript',
  'ts=typescript',
  'shell=sh',
  'bash=sh',
  'console=sh',
  'scss=scss',
  'css=css',
  'html=html',
}

vim.opt.pumheight = 15
vim.opt.confirm = true
vim.opt.autowriteall = true -- automatically :write before running commands and changing files

vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider   = 0
vim.g.loaded_perl_provider   = 0
vim.g.loaded_node_provider   = 0

local disabled_built_ins = {
  -- 'netrw', -- required by :GBrowse
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'tar',
  'tarPlugin',
  'vimball',
  'vimballPlugin',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end

vim.g.mapleader = ','

" vim:foldmethod=marker

lua require('options')
lua require('_lazy')

let s:signes = {
            \   'branch': emoji#available() ? emoji#for('trident') : '',
            \   'lock': emoji#available() ? emoji#for('lock') : '',
            \   'error': emoji#for('skull'),
            \   'warning': emoji#for('zap'),
            \   'ok': emoji#for('+1')
            \ }

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

augroup GoLang
  autocmd!
  autocmd FileType go setlocal tabstop=4 shiftwidth=4
  autocmd FileType go let b:ale_fix_on_save=1
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://www.reddit.com/r/vim/comments/17vpwyw/where_do_the_fugitive_folders_come_from_and_how/k9cura3
function! s:mkdir(path)
  if a:path =~? '^fugitive://'
    return
  endif
  if a:path =~? '^oil://'
    return
  endif
  if a:path =~? '^diffview://'
    return
  endif
  call mkdir(a:path, 'p')
endfunction

augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
        \ call s:mkdir(expand("<afile>:p:h")) |
    \ endif
augroup END

" Autoread will automatically update an open buffer if it has been changed outside the current
" edit session, usually by an external program
augroup autoRead
  autocmd!
  autocmd CursorHold * silent! checktime
augroup END

" Automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =

" lua require('lsp')


"----YankStack {{{
" Prevent collision with vim-surrond 'S' in visual mode mapping
" call yankstack#setup()

" nmap <leader>p <Plug>yankstack_substitute_older_paste
" nmap <leader>P <Plug>yankstack_substitute_newer_paste
"}}}

"---- Limelight {{{
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1
"
"}}}

"---- GITGUTTER{{{
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_grep = 'rg'

" if emoji#available()
  " let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
  " let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
  " let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
  " let g:gitgutter_sign_modified_removed = emoji#for('collision')
" endif
" let g:gitgutter_sign_added = '❙'
" let g:gitgutter_sign_modified = '❙'
" let g:gitgutter_sign_removed = '❙'
" let g:gitgutter_sign_modified_removed = '❙'

" realtime updates disabled in ./after/plugin/gitgutter.nvim
" see https://github.com/airblade/vim-gitgutter#faq

" autocmd BufWritePost * GitGutter
"}}}
"

"---- NerdCommenter {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
"let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"}}}

" ---- Choosewin {{{
nmap  -  <Plug>(choosewin)
" let g:choosewin_overlay_enable = 1

" workaround for the overlay font being broken on mutibyte buffer.
" let g:choosewin_overlay_clear_multibyte = 1

" tmux-like overlay color
" let g:choosewin_color_overlay = {
            " \ 'gui': ['DodgerBlue3', 'DodgerBlue3'],
            " \ 'cterm': [25, 25]
            " \ }
" let g:choosewin_color_overlay_current = {
            " \ 'gui': ['firebrick1', 'firebrick1'],
            " \ 'cterm': [124, 124]
            " \ }

let g:choosewin_blink_on_land      = 0 " don't blink at land
" let g:choosewin_statusline_replace = 0 " don't replace statusline
" let g:choosewin_tabline_replace    = 0 " don't replace tabline
"  }}}

"---- {{{ Startify
let g:startify_list_order = ['sessions', 'files', 'dir', 'bookmarks',
            \ 'commands']

let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
let g:startify_enable_special = 0
let g:startify_update_oldfiles = 1
"}}}

"---- {{{ Ale

" https://github.com/dense-analysis/ale/issues/3167#issuecomment-721280756
function! FormatGo(buffer) abort
    return {
    \   'command': 'gofumpt'
    \}
endfunction

" execute ale#fix#registry#Add('gofumpt', 'FormatGo', ['go'], 'gofumpt for go')

let g:ale_go_golangci_lint_options = ''
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'scss': ['stylelint'],
\   'go' : ['golangci-lint'],
\}

let g:ale_fixers = {
      \ 'javascript': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'vue': ['prettier', 'eslint'],
      \ 'scss': ['prettier', 'stylelint'],
      \ 'markdown' : ['prettier'],
      \ 'go' : ['gofumpt'],
      \ }

let g:ale_linters_ignore = {'rust': ['cargo', 'rls']}

" let g:ale_virtualtext_cursor = 1
" let g:ale_virtualtext_delay = 50

let g:ale_rust_rls_toolchain = 'stable'

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ?  s:signes.ok . ' ' : printf(
    \   '%d' . s:signes.warning . '%d' . s:signes.error,
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" let g:ale_sign_error = '✗'
" let g:ale_sign_error = '✕'
let g:ale_sign_error = s:signes.error
" let g:ale_sign_error = emoji#for('skull')
" let g:ale_sign_error = '✖'
" let g:ale_sign_warning = '⚠'
let g:ale_sign_warning = s:signes.warning
let g:ale_lint_delay = 700

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Oceanic next
" hi ALEErrorSign guifg=red guibg=#343D46

" Base2Tone-Meadow-dark
" hi ALEErrorSign guifg=red guibg=#192834

" Solarized dark
" hi ALEErrorSign guifg=red guibg=#073642
" hi ALEWarningSign guifg=yellow guibg=#073642

" flatcolor
" hi ALEErrorSign guifg=red guibg=#1E1C31
" hi ALEWarningSign guifg=yellow guibg=#1E1C31

" Gruvbox
" hi ALEErrorSign guifg=red guibg=#3c3836
" hi ALEWarningSign guifg=yellow guibg=#3c3836

let g:ale_sign_column_always = 0

let g:ale_html_htmlhint_options = '--config ~/.htmlhintrc --format=unix'

nmap <silent> <Leader>ep <Plug>(ale_previous_wrap)
nmap <silent> <Leader>en <Plug>(ale_next_wrap)
nmap gF <Plug>(ale_fix)
" let g:ale_hover_cursor = 0
let g:ale_cursor_detail = 0
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']
let g:ale_floating_preview = 1
let g:ale_detail_to_floating_preview = 1
let g:ale_hover_to_floating_preview = 1
"}}}

"---- Javascript-libraries-syntax {{{
let g:used_javascript_libs = 'jquery,vue'
"}}}

"---- {{{ Vim-Slash
noremap <plug>(slash-after) zz
"}}}

"---- Sayonara {{{
nnoremap <silent><leader>q  :Sayonara<cr>
nnoremap <silent><leader>Q  :Sayonara!<cr>
"}}}

"---- lightline {{{

" highlight link ALEWarningSign String
" highlight link ALEErrorSign Title

" function! LightlineReadonly()
"     return &readonly ? s:signes.lock : ''
" endfunction
" function! LightlineFugitive()
"     if exists('*fugitive#head')
"         let branch = FugitiveHead()
"         return branch !=# '' ? s:signes.branch . ' '.branch : ''
"     endif
"     return ''
" endfunction

" let g:lightline#ale#indicator_checking = emoji#for('clock1')
" let g:lightline#ale#indicator_warnings = s:signes.warning
" let g:lightline#ale#indicator_errors = s:signes.error
" let g:lightline#ale#indicator_ok = s:signes.ok

" let g:lightline = {
"             \ 'separator': { 'left': "", 'right': "" },
"             \ 'subseparator': { 'left': "", 'right': "" },
"             \ 'mode_map': {
"             \ 'n' : 'N',
"             \ 'i' : 'I',
"             \ 'R' : 'R',
"             \ 'v' : 'V',
"             \ 'V' : 'V-L',
"             \ "\<C-v>": 'V-B',
"             \ 'c' : 'C',
"             \ 's' : 'S',
"             \ 'S' : 'S-L',
"             \ "\<C-s>": 'S-B',
"             \ 't': 'T',
"             \ },
"             \ 'colorscheme': 'base16_grayscale_dark',
"             \ 'active': {
"             \   'left': [ [ 'mode', 'paste' ],
"             \             [ 'gitbranch', 'readonly', 'filename', 'mymodified' ] ],
"             \   'right': [ [ 'lineinfo' ],
"             \              [ 'percent' ],
"             \              [ 'filetype' ],
"             \              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ]
"             \ },
"             \ 'component_function': {
"             \   'readonly': 'LightlineReadonly',
"             \   'gitbranch': 'LightlineFugitive',
"             \   'mymodified': 'LightlineModified',
"             \ },
"             \ 'component_type': {
"             \     'linter_checking': '',
"             \     'linter_warnings': '',
"             \     'linter_errors': '',
"             \     'linter_ok': '',
"             \   'readonly': 'error'
"             \ },
"             \ }

" function! LightlineModified()
"     return &modifiable && &modified ? emoji#for('alien') : ''
" endfunction

"}}}

"---- {{{ Goyo
function! s:goyo_enter()
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set noshowmode
    set noshowcmd
    " set scrolloff=999
    Limelight
    " ALEDisable
    " call lightline#disable()
endfunction

function! s:goyo_leave()
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    set showmode
    set showcmd
    " set scrolloff=5
    Limelight!
    " ALEEnable
    " call lightline#enable()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
"}}}

"{{{ ---- CtrlSF
let g:ctrlsf_ackprg = '/usr/bin/rg'
let g:ctrlsf_auto_close = 0
"}}}

"{{{ ---- AsyncRun
nnoremap <F9> :AsyncRun -mode=term -focus=1 

let g:asyncrun_open = 8

augroup AsyncRun
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
    autocmd FileType rust nnoremap <F8> :AsyncRun -mode=term cargo run<CR>
    autocmd FileType go nnoremap <F8> :AsyncRun -mode=term -focus=0 go run .<CR>
    autocmd FileType go nnoremap <F10> :AsyncRun -focus=0 go install<CR>
    " autocmd FileType c noremap <F8> :AsyncRun gcc "%" -o "%<" <cr>
    " autocmd FileType cpp noremap <F8> :AsyncRun g++ "%" -o "%<" <cr>
    " autocmd FileType cpp noremap <F7> :AsyncRun "./%<" <cr>
augroup END
"}}}

" thesaurus_query{{{
let g:tq_map_keys=0
"}}}

"{{{ ---- vim-editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_max_line_indicator = 'none'
"}}}

"{{{ Ferret
let g:FerretMap=0
"}}}

"{{{ --- vim vue
let g:vue_pre_processors = 'detect_on_enter'
"}}}

"---- {{{ Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"}}}

"{{{ table-mode
let g:table_mode_corner = '+'
let g:table_mode_corner_corner='+'
let g:table_mode_header_fillchar='='
let g:table_mode_syntax=0
"}}}

"{{{ floaterm
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let $MAZ_DISABLE_EXTENSION=1
command! FN FloatermNew
command! FT FloatermToggle
command! FPush FloatermNew! git push
tnoremap <leader>f<Esc> <C-\><C-n>:FloatermToggle<CR>
"}}}

"{{{ vim-go
let g:go_code_completion_enabled = 0
let g:go_jump_to_error = 0
let g:go_fmt_autosave = 0
let g:go_imports_autosave = 0
let g:go_mod_fmt_autosave = 0
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []
let g:go_textobj_enabled = 0

let g:go_gopls_gofumpt = v:true

let g:go_highlight_string_spellcheck = 0
let g:go_highlight_format_strings = 0
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0
"}}}

" {{{ nvim-miniyank
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>p <Plug>(miniyank-cycle)
map <leader>P <Plug>(miniyank-cycleback)
" }}}

" {{{ zen-mode
" lua << EOF
"   require("zen-mode").setup {
"      window = {
"       backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
"       -- height and width can be:
"       -- * an absolute number of cells when > 1
"       -- * a percentage of the width / height of the editor when <= 1
"       -- * a function that returns the width or the height
"       width = 100, -- width of the Zen window
"       height = 1, -- height of the Zen window
"       -- by default, no options are changed for the Zen window
"       -- uncomment any of the options below, or add other vim.wo options you want to apply
"       options = {
"         signcolumn = "no", -- disable signcolumn
"         number = false, -- disable number column
"         relativenumber = false, -- disable relative numbers
"         wrap = true,
"         colorcolumn = ""
"         -- cursorline = false, -- disable cursorline
"         -- cursorcolumn = false, -- disable cursor column
"         -- foldcolumn = "0", -- disable fold column
"         -- list = false, -- disable whitespace characters
"       },
"     },
"     -- callback where you can add custom code when the Zen window opens
"     on_open = function(win)
"       vim.cmd('Limelight')
"     end,
"     -- callback where you can add custom code when the Zen window closes
"     on_close = function()
"       vim.cmd('Limelight!')
"     end,
"   }
" EOF
" }}}

" {{{ vim-mergetool
" let g:mergetool_layout = 'bmr'
let g:mergetool_layout = 'mr'
" let g:mergetool_layout = 'LmR'
let g:mergetool_prefer_revision = 'local'
" }}}

" {{{ vim-matchup
let g:matchup_matchparen_deferred = 1
" }}}

lua require('_fugitive')

lua require('_winbar')

" see https://github.com/neovim/neovim/issues/19458
" lua require('_winbar-gps')

lua require('_lorem-picsum')

lua require('_lsp/init')

lua require('_autocmd')

set langmap=
  \ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ї},ФA,ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Є\\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,
  \йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ї],фa,іs,вd,аf,пg,рh,оj,лk,дl,ж\\;,є',яz,чx,сc,мv,иb,тn,ьm

filetype plugin on
filetype indent on

map <leader>bl :b#<cr>

nnoremap / /\v
vnoremap / /\v

" autoclose tag
inoremap </ </<C-x><C-o>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

nmap <c-s> :wa!<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

"----Terminal emulator config {{{
tnoremap <leader><Esc> <C-\><C-n>
tnoremap <leader><leader><Esc> <C-\><C-n><C-W>p
"}}}

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change cursor position in insert mode
inoremap <C-b> <left>
inoremap <C-f> <right>
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k

" Explore hotkey
map <F7> :Explore<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>

" Return to last edit position when opening files (You want this!)
augroup lastEditedPosition
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
nnoremap 0 ^

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickly open a markdown buffer for scribble
map <leader>x :tabnew ~/notes<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
function! CmdLine(str)
    exe 'menu Foo.Bar :' . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute 'normal! vgvy'

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, '\n$', '', '')

    if a:direction == 'b'
        execute 'normal ?' . l:pattern . '^M'
    elseif a:direction == 'gv'
        call CmdLine('vimgrep ' . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine('%s' . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute 'normal /' . l:pattern . '^M'
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

augroup filetype_vue
    autocmd!
    autocmd FileType vue syntax sync fromstart
    autocmd FileType vue let b:ale_fix_on_save=0
    au FileType vue let b:coc_root_patterns = ['.git', '.env', 'package.json', 'tsconfig.json', 'jsconfig.json', 'vite.config.ts', 'nuxt.config.ts']
augroup END

" ==============================
" Back to normal mode
inoremap kj <esc>

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Select entire buffer
nnoremap vaa ggvGg_
" nnoremap Vaa ggVG

" Source
" vnoremap <leader>S y:@"<CR>
" nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap g; g;zvzz
nnoremap g, g,zvzz

nnoremap } }zz
nnoremap { {zz

nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-f> <C-f>zz
nnoremap <C-b> <C-b>zz
vnoremap <C-u> <C-u>zz
vnoremap <C-d> <C-d>zz
vnoremap <C-f> <C-f>zz
vnoremap <C-b> <C-b>zz

nnoremap <S-tab> <c-w>w

noremap H ^
noremap L $
vnoremap L g_

map <tab> %

noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

vnoremap > >gv
vnoremap < <gv

" Quickly select the text that was just pasted. This allows you to, e.g.,
" indent it after pasting.
noremap gV `[v`]

" Yank and paste from clipboard
" NOTE: not used right now due to ibhagwan/smartyank.nvim
" nnoremap \y "+y
" vnoremap \y "+y
" nnoremap \yy "+yy
" nnoremap \p "+p

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" https://bluz71.github.io/2019/03/11/find-replace-helpers-for-vim.html
nnoremap <leader>s :%s#<C-r><C-w>##<Left>
xnoremap <leader>s "sy:%s#<C-r>s##<Left>

lua require('_neovide')

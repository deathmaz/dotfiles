" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! DoRemote(arg)
    UpdateRemotePlugins
endfunction

" Should be placed before plugin load
let g:ale_disable_lsp = 1

let g:loaded_python_provider = 0
" let g:python3_host_prog = '~/.pyenv/versions/3.8.5/bin/python'

"---- Plug {{{
call plug#begin()
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'pwntester/octo.nvim'
call plug#end()
"}}}

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let g:mapleader = ","

" ---- {{{ Variables
let s:signes = {
            \   'branch': emoji#available() ? emoji#for('trident') : '',
            \   'lock': emoji#available() ? emoji#for('lock') : '',
            \   'error': emoji#for('skull'),
            \   'warning': emoji#for('zap'),
            \   'ok': emoji#for('+1')
            \ }
" }}}

" https://github.com/vim/vim/issues/4738
function! OpenURLUnderCursor()
  let s:uri = expand('<cWORD>')
  let s:uri = matchstr(s:uri, '[a-z]*:\/\/[^ >,;()]*')
  let s:uri = substitute(s:uri, '?', '\\?', '')
  let s:uri = shellescape(s:uri, 1)
  if s:uri != ''
    if has('macunix')
      silent exec "!open '".s:uri."'"
    else
      silent exec "!xdg-open '".s:uri."'"
    endif
    :redraw!
  endif
endfunction
nnoremap gx :call OpenURLUnderCursor()<CR>

" https://bluz71.github.io/2019/03/11/find-replace-helpers-for-vim.html
nnoremap <Leader>s :let @s='\<'.expand('<cword>').'\>'<CR>:%s/<C-r>s//<Left>
xnoremap <Leader>s "sy:%s/<C-r>s//<Left>

augroup GoLang
  autocmd!
  autocmd FileType go setlocal tabstop=4 shiftwidth=4
  autocmd FileType go let b:ale_fix_on_save=1
  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://github.com/neovim/neovim/pull/6597#issuecomment-299475512
" if exists('+winhighlight')
  " function! s:configure_winhighlight()
    " let ft = &filetype
    " let bt = &buftype
    " " Check white/blacklist.
    " if index(['dirvish'], ft) == -1
          " \ && (index(['nofile', 'nowrite', 'acwrite', 'quickfix', 'help'], bt) != -1
          " \     || index(['startify'], ft) != -1)
      " set winhighlight=Normal:MyNormalWin,NormalNC:MyNormalWin
      " " echom "normal" winnr() &winhighlight 'ft:'.&ft 'bt:'.&bt
    " else
      " set winhighlight=Normal:MyNormalWin,NormalNC:MyInactiveWin
      " " echom "inactive" winnr() &winhighlight 'ft:'.&ft 'bt:'.&bt
    " endif
  " endfunction
  " augroup inactive_win
    " au!
    " au ColorScheme * hi link MyInactiveWin ColorColumn | hi link MyNormalWin Normal
    " au FileType,BufWinEnter * call s:configure_winhighlight()
    " au FocusGained * hi link MyNormalWin Normal
    " au FocusLost * hi link MyNormalWin MyInactiveWin
  " augroup END
" endif

" General for all autocompletion plugins
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" hide cursorline in insert mode
" augroup insertCursor
"     autocmd!
"     autocmd WinEnter    * set cursorline
"     autocmd WinLeave    * set nocursorline
"     autocmd InsertEnter * set nocursorline
"     autocmd InsertLeave * set cursorline
" augroup END

augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
augroup END

augroup WincentAutocmds
  if exists('##TextYankPost')
    au TextYankPost * silent! lua vim.highlight.on_yank {higroup="Substitute", timeout=200}
  endif
augroup END

set noswapfile
set nobackup

" https://bluz71.github.io/2017/05/15/vim-tips-tricks.html
" TODO check if it's possible to move this to lua configs
set breakindent
set breakindentopt=shift:2
set showbreak=↳
set wildmenu
set wildmode=full
set mouse=a

" Autoread will automatically update an open buffer if it has been changed outside the current
" edit session, usually by an external program
set autoread
augroup autoRead
  autocmd!
  autocmd CursorHold * silent! checktime
augroup END

" Automatically equalize splits when Vim is resized
autocmd VimResized * wincmd =

lua require('options')
" lua require('gitsigns')
" lua require('lsp')

" Enable filetype plugins

set langmap=
  \ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,Х{,Ї},ФA,ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,Ж:,Є\\",ЯZ,ЧX,СC,МV,ИB,ТN,ЬM,Б<,Ю>,
  \йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,х[,ї],фa,іs,вd,аf,пg,рh,оj,лk,дl,ж\\;,є',яz,чx,сc,мv,иb,тn,ьm

filetype plugin on
filetype indent on

map <leader>bl :b#<cr>

highlight cursorline term=underline cterm=underline ctermbg=0 gui=underline guibg=NONE guisp=grey40

nnoremap / /\v
vnoremap / /\v

" autoclose tag
inoremap </ </<C-x><C-o>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

try
  " set background=dark
  " colorscheme solarized8

  let g:seoul256_background = 235
  " colorscheme seoul256

  let g:gruvbox_contrast_dark = 'hard'
  let g:gruvbox_invert_selection='0'
  " colorscheme gruvbox

  " colorscheme base16-grayscale-dark
  colorscheme 256_noir
  " colorscheme github_dimmed
  " colorscheme base16-gruvbox-light-medium
  " colorscheme candle-grey
  " colorscheme atlas
catch
endtry

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
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

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
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>
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
nnoremap \y "+y
vnoremap \y "+y
nnoremap \yy "+yy
nnoremap \p "+p

nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" {{{ octo.nvim
lua << EOF
require"octo".setup()
EOF
" }}}

"{{{ ---- coc.nvim
let g:coc_status_error_sign = s:signes.error
let g:coc_status_warning_sign = s:signes.warning

let g:coc_global_extensions = [
      \ 'coc-word',
      \ 'coc-tsserver',
      \ 'coc-blade',
      \ 'coc-sh',
      \ 'coc-snippets',
      \ 'coc-prettier',
      \ 'coc-lists',
      \ 'coc-emoji',
      \ 'coc-emmet',
      \ 'coc-yaml',
      \ '@yaegassy/coc-volar',
      \ '@yaegassy/coc-intelephense',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-eslint',
      \ 'coc-stylelint',
      \ 'coc-docker',
      \ 'coc-css',
      \ 'coc-rust-analyzer',
      \ 'coc-sumneko-lua',
      \ ]

" Better display for signatures

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent><nowait> \o  :<C-u>CocFzfList outline<cr>
nnoremap <silent><nowait> \s  :<C-u>CocList symbols<cr>
nnoremap <silent><nowait> \a  :<C-u>CocFzfList commands<cr>
nnoremap <silent> \d       :<C-u>CocFzfList diagnostics --current-buf<CR>

nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> \gd :call CocAction('jumpDefinition')<CR>
nmap <silent> \gr <Plug>(coc-references)

xmap <leader>cl  <Plug>(coc-codeaction-selected)
nmap <leader>cl  <Plug>(coc-codeaction-selected)

" Show signature help while editing
" autocmd CursorHoldI,CursorMovedI * silent! call CocAction('showSignatureHelp')
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

augroup coc
    autocmd FileType cpp,vue,javascript,typescript,typescriptreact,html,blade noremap <C-k> :call CocAction('format') <cr>
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END
call coc#config('git.changedSign', {
            \ 'text': '┃',
            \ 'hlGroup': 'GitGutterChange',
            \})

call coc#config('git.addedSign', {
            \ 'text': '+',
            \ 'hlGroup': 'GitGutterAdd',
            \})

call coc#config('git.removedSign', {
            \ 'text': '-',
            \ 'hlGroup': 'GitGutterDelete',
            \})

call coc#config('git.changeRemovedSign', {
            \ 'text': '•',
            \ 'hlGroup': 'GitGutterDelete',
            \})

call coc#config('diagnostic.errorSign', s:signes.error)

call coc#config('diagnostic.warningSign', s:signes.warning)

" Use <cr> for confirm completion.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

nnoremap <silent><nowait><expr> <M-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<M-f>"
nnoremap <silent><nowait><expr> <M-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<M-b>"
inoremap <silent><nowait><expr> <M-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <M-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <M-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<M-f>"
vnoremap <silent><nowait><expr> <M-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<M-b>"
"}}}

" ---- FZF {{{
" set rtp+=~/.fzf

" see https://github.com/junegunn/fzf.vim/issues/838#issuecomment-509902575
" command! -bang -nargs=* Rg call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case '.<q-args>, 1, <bang>0)

nnoremap <silent> <Leader>ag :Rg <C-R><C-W><CR>
" nnoremap <silent> <Leader>AG :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag y:Rg <C-R>"<CR>
" nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>
" nnoremap <leader>d :call fzf#vim#tags(expand('<cword>'), {'options': '--exact'})<CR>

" go to relative file
nnoremap <silent> <Leader>ef :execute 'Files' expand('%:h')<CR>

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Jag
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --type=js --type=ts --color=always --smart-case '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)


" command! -nargs=+ -complete=file Rag call fzf#vim#ag_raw(<q-args>)
function! s:ag_with_opts(arg, bang)
    let tokens  = split(a:arg)
    let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
    let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
    call fzf#vim#ag(query, ag_opts, a:bang ? {} : {'down': '40%'})
endfunction

" autocmd VimEnter * command! -nargs=* -bang Jag call s:ag_with_opts('--js', <bang>0)
" an example
" autocmd VimEnter * command! -nargs=* -bang Ago call s:ag_with_opts(<q-args>, <bang>0)

" autocmd! VimEnter * command! -nargs=* -complete=file Jag :call fzf#vim#ag_raw('--js '. <q-args>)
nnoremap \bt :BTags<CR>
nnoremap \\t :Tags<CR>
" nnoremap <leader>c :Commands<CR>

nnoremap <leader>f :Files<CR>
nnoremap <leader>v :Buffers<CR>
nnoremap <leader>L :Lines<CR>
nnoremap <Leader>ss :BLines<CR>
nnoremap \f :GFiles?<CR>

" This is the default extra key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }


let g:fzf_files_options =
            \ '--bind ctrl-h:preview-down,ctrl-l:preview-up --preview "(bat --style=numbers --color=always --line-range :500 {} || cat {}) 2> /dev/null | head -200"'

" [Buffers] Jump to the existing window if possible
" let g:fzf_buffers_jump = 1

" For Commits and BCommits to customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Customize fzf colors to match your color scheme

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'hl':      ['fg', 'Conditional'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-w> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
" https://github.com/junegunn/fzf.vim/pull/628#issuecomment-1182944962
inoremap <expr> <c-x><c-j> fzf#vim#complete("rg --files --hidden --no-ignore --null <Bar> xargs --null realpath --relative-to " . expand("%:h"))

function! s:make_path(path)
    let bPath = expand('%:p:h')
    let fPath = system("realpath " . join(a:path))
    let relPath = system("relative-path " . bPath . " " . fPath)
    return substitute(relPath, '\n\+$', '', '')
endfunction

inoremap <expr> <c-x><c-s> fzf#complete(fzf#wrap({
            \ 'source':  'rg --files',
            \ 'reducer': function('<sid>make_path')}))

" Global line completion (not just open buffers. ripgrep required.)
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
      \ 'prefix': '^.*$',
      \ 'source': 'rg -n ^ --color always',
      \ 'options': '--ansi --delimiter : --nth 3..',
      \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))

function! s:fzf_statusline()
    " Override statusline as you like
    highlight fzf1 ctermfg=11 ctermbg=236
    highlight fzf2 ctermfg=228 ctermbg=236
    highlight fzf3 ctermfg=228 ctermbg=236
    setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

augroup fzf_statusline
    autocmd!
    autocmd User FzfStatusLine call <SID>fzf_statusline()
augroup END

autocmd VimEnter * command! -bang -nargs=* Ag
            \ call fzf#vim#ag(<q-args>,
            \                 <bang>0 ? fzf#vim#with_preview('up:60%')
            \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
            \                 <bang>0)

" autocmd VimEnter * command! Files
"    \ call fzf#vim#buffers('', { 'window': 'aboveleft 20new', 'options': $FZF_CTRL_T_OPTS })

" Terminal buffer options for fzf
autocmd! FileType fzf
autocmd  FileType fzf set noshowmode noruler nonu

let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.8 } }

"}}}

" ---- UltiSnips {{{
" let g:UltiSnipsExpandTrigger='<c-q><c-q>'
" let g:UltiSnipsJumpForwardTrigger='<c-q><c-n>'
" let g:UltiSnipsJumpBackwardTrigger='<c-q><c-h>'
"  }}}

"{{{ fern
let g:fern#disable_default_mappings          = 1
let g:fern#disable_drawer_smart_quit         = 1
let g:fern#default_hidden                    = 1
let g:fern#mark_symbol                       = '●'
let g:fern#renderer#default#collapsed_symbol = '▷ '
let g:fern#renderer#default#expanded_symbol  = '▼ '
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '

" noremap <silent> <Leader>d :Fern . -drawer -width=35 -toggle<CR><C-w>=
noremap <silent> <Leader>d :Fern . -drawer -reveal=% -width=35<CR><C-w>=
noremap <silent> <Leader>. :Fern %:h -drawer -width=35<CR><C-w>=

function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> m <Plug>(fern-action-mark:toggle)j
  nmap <buffer> N <Plug>(fern-action-new-file)
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> V <Plug>(fern-action-move)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> <BS> <Plug>(fern-action-focus:parent)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> <nowait> d <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> < <Plug>(fern-action-leave)
  nmap <buffer> <nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernEvents
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

augroup FernTypeGroup
  autocmd! * <buffer>
  autocmd BufEnter <buffer> silent execute "normal \<Plug>(fern-action-reload)"
augroup END
"}}}

"{{{ fern-git-status
let g:fern_git_status#disable_ignored    = 1
let g:fern_git_status#disable_untracked  = 1
let g:fern_git_status#disable_submodules = 1
"}}}


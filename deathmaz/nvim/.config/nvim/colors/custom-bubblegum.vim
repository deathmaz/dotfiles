" Bubblegum 256 Dark
"  Author: baskerville <nihilhill@gmail.com>
"     URL: github.com/baskerville/bubblegum
" Created: 2011
" Version: 0.3

hi clear

if exists("syntax_on")
    syntax reset
endif

let g:colors_name="custom-bubblegum"


" Main
" hi Normal ctermfg=249 ctermbg=234 cterm=none guifg=#B2B2B2 guibg=#262626 gui=none
hi Normal ctermfg=253 ctermbg=234 cterm=none guifg=#B2B2B2 guibg=#262626 gui=none
hi Comment ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none

" Constant

" $ sign in jquery
hi Constant ctermfg=221 ctermbg=234 cterm=bold guifg=#D7D787 guibg=#262626 gui=none

"
" hi String ctermfg=187 ctermbg=234 cterm=none guifg=#D7D7AF guibg=#262626 gui=none
" $("string")
hi String ctermfg=193 ctermbg=234 cterm=none guifg=#D7D7AF guibg=#262626 gui=none
hi Character ctermfg=187 ctermbg=234 cterm=none guifg=#D7D7AF guibg=#262626 gui=none

" numbers
hi Number ctermfg=202 ctermbg=234 cterm=none guifg=#D7AF87 guibg=#262626 gui=none

" true false
hi Boolean ctermfg=221 ctermbg=234 cterm=none guifg=#D7D7AF guibg=#262626 gui=none
hi Float ctermfg=202 ctermbg=234 cterm=none guifg=#D7AF87 guibg=#262626 gui=none

" Variable Name
hi Identifier ctermfg=183 ctermbg=234 cterm=none guifg=#D7AFD7 guibg=#262626 gui=none

"function name
hi Function ctermfg=111 ctermbg=234 cterm=bold guifg=#D7AFD7 guibg=#262626 gui=none

" Statement
hi Statement ctermfg=110 ctermbg=234 cterm=none guifg=#87AFD7 guibg=#262626 gui=none

" if
hi Conditional ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Repeat ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Label ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Operator ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Keyword ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Exception ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none

" Preprocessor
" hi PreProc ctermfg=10 ctermbg=234 cterm=none guifg=#AFD787 guibg=#262626 gui=none
" hi PreProc ctermfg=150 ctermbg=234 cterm=none guifg=#AFD787 guibg=#262626 gui=none
hi PreProc ctermfg=111 ctermbg=234 cterm=none guifg=#AFD787 guibg=#262626 gui=none
hi Include ctermfg=150 ctermbg=234 cterm=none guifg=#AFD787 guibg=#262626 gui=none
hi Define ctermfg=150 ctermbg=234 cterm=none guifg=#AFD787 guibg=#262626 gui=none
hi Macro ctermfg=150 ctermbg=234 cterm=none guifg=#AFD787 guibg=#262626 gui=none
hi PreCondit ctermfg=150 ctermbg=234 cterm=none guifg=#AFD787 guibg=#262626 gui=none

" Type
" hi Type ctermfg=146 ctermbg=234 cterm=none guifg=#AFAFD7 guibg=#262626 gui=none
" function
hi Type ctermfg=183 ctermbg=234 cterm=bold guifg=#AFAFD7 guibg=#262626 gui=none
" var
hi StorageClass ctermfg=183 ctermbg=234 cterm=bold guifg=#AFAFD7 guibg=#262626 gui=none
hi Structure ctermfg=146 ctermbg=234 cterm=none guifg=#AFAFD7 guibg=#262626 gui=none
hi Typedef ctermfg=146 ctermbg=234 cterm=none guifg=#AFAFD7 guibg=#262626 gui=none

" Special
" this
hi Special ctermfg=221 ctermbg=234 cterm=bold guifg=#D78787 guibg=#262626 gui=none
hi SpecialChar ctermfg=173 ctermbg=234 cterm=none guifg=#D78787 guibg=#262626 gui=none
hi Tag ctermfg=174 ctermbg=234 cterm=none guifg=#D78787 guibg=#262626 gui=none
hi Delimiter ctermfg=174 ctermbg=234 cterm=none guifg=#D78787 guibg=#262626 gui=none
hi SpecialComment ctermfg=174 ctermbg=234 cterm=none guifg=#D78787 guibg=#262626 gui=none
hi Debug ctermfg=174 ctermbg=234 cterm=none guifg=#D78787 guibg=#262626 gui=none
hi Underlined ctermfg=249 ctermbg=234 cterm=underline guifg=#B2B2B2 guibg=#262626 gui=underline
hi Ignore ctermfg=234 ctermbg=234 cterm=none guifg=#262626 guibg=#262626 gui=none
hi Error ctermfg=231 ctermbg=167 cterm=none guifg=#FFFFFF guibg=#D75F5F gui=none
hi Todo ctermfg=202 ctermbg=236 cterm=bold guifg=#808080 guibg=#262626 gui=none

" Window
hi StatusLine ctermfg=249 ctermbg=237 cterm=none guifg=#B2B2B2 guibg=#3A3A3A gui=none
hi StatusLineNC ctermfg=244 ctermbg=237 cterm=none guifg=#808080 guibg=#3A3A3A gui=none
hi TabLine ctermfg=249 ctermbg=237 cterm=none guifg=#B2B2B2 guibg=#3A3A3A gui=none
hi TabLineSel ctermfg=253 ctermbg=234 cterm=none guifg=#DADADA guibg=#444444 gui=none
hi TabLineFill ctermbg=237 cterm=none guibg=#3A3A3A gui=none
hi VertSplit ctermfg=237 ctermbg=237 cterm=none guifg=#3A3A3A guibg=#3A3A3A gui=none

" Menu
hi Pmenu ctermfg=249 ctermbg=237 cterm=none guifg=#B2B2B2 guibg=#3A3A3A gui=none
hi PmenuSel ctermfg=231 ctermbg=244 cterm=none guifg=#FFFFFF guibg=#808080 gui=none
hi PmenuSbar ctermbg=59 cterm=none guibg=#5F5F5F gui=none
hi PmenuThumb ctermbg=246 cterm=none guibg=#949494 gui=none
hi WildMenu ctermfg=232 ctermbg=98 cterm=none guifg=#080808 guibg=#875FD7 gui=none

" Selection
hi Visual ctermfg=234 ctermbg=117 cterm=none guifg=#262626 guibg=#87D7FF gui=none
hi VisualNOS ctermfg=234 ctermbg=80 cterm=none guifg=#262626 guibg=#5FD7D7 gui=none

" Message
hi ErrorMsg ctermfg=210 ctermbg=234 cterm=none guifg=#FF8787 guibg=#262626 gui=none
hi WarningMsg ctermfg=140 ctermbg=234 cterm=none guifg=#AF87D7 guibg=#262626 gui=none
hi MoreMsg ctermfg=72 ctermbg=234 cterm=none guifg=#5FAF87 guibg=#262626 gui=none
hi ModeMsg ctermfg=222 ctermbg=234 cterm=bold guifg=#FFD787 guibg=#262626 gui=bold
hi Question ctermfg=38 ctermbg=234 cterm=none guifg=#00AFD7 guibg=#262626 gui=none

" Mark
hi Folded ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none
hi FoldColumn ctermfg=79 ctermbg=237 cterm=none guifg=#5FD7AF guibg=#3A3A3A gui=none
hi SignColumn ctermfg=184 ctermbg=237 cterm=none guifg=#D7D700 guibg=#3A3A3A gui=none
" inactive window bgrd
hi ColorColumn ctermbg=235 cterm=none guibg=#3A3A3A gui=none
hi LineNr ctermfg=244 ctermbg=237 cterm=none guifg=#808080 guibg=#3A3A3A gui=none
hi MatchParen ctermfg=16 ctermbg=215 cterm=none guifg=#000000 guibg=#FFAF5F gui=none

" Cursor
hi CursorColumn ctermbg=236 cterm=none guibg=#3A3A3A gui=none
hi CursorLine ctermbg=236 cterm=none guibg=#3A3A3A gui=none
hi CursorLineNr ctermfg=249 ctermbg=236 cterm=none guifg=#B2B2B2 guibg=#3A3A3A gui=none

" Search
hi Search ctermfg=16 ctermbg=179 cterm=none guifg=#000000 guibg=#D7AF5F gui=none
hi IncSearch ctermfg=231 ctermbg=168 cterm=none guifg=#FFFFFF guibg=#D75F87 gui=none

" Diff Mode
hi DiffAdd ctermfg=16 ctermbg=149 cterm=none guifg=#000000 guibg=#AFD75F gui=none
hi DiffChange ctermfg=16 ctermbg=217 cterm=none guifg=#000000 guibg=#FFAFAF gui=none
hi DiffText ctermfg=16 ctermbg=211 cterm=bold guifg=#000000 guibg=#FF87AF gui=bold
hi DiffDelete ctermfg=16 ctermbg=249 cterm=none guifg=#000000 guibg=#B2B2B2 gui=none

" Spell
hi SpellBad ctermfg=210 ctermbg=234 cterm=underline guifg=#FF8787 guibg=#262626 gui=underline
hi SpellCap ctermfg=174 ctermbg=234 cterm=underline guifg=#D78787 guibg=#262626 gui=underline
hi SpellRare ctermfg=181 ctermbg=234 cterm=underline guifg=#D7AFAF guibg=#262626 gui=underline
hi SpellLocal ctermfg=180 ctermbg=234 cterm=underline guifg=#D7AF87 guibg=#262626 gui=underline

" Misc
hi SpecialKey ctermfg=114 ctermbg=234 cterm=none guifg=#87D787 guibg=#262626 gui=none
hi NonText ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none
hi Directory ctermfg=103 ctermbg=234 cterm=none guifg=#8787AF guibg=#262626 gui=none
hi Title ctermfg=109 cterm=none guifg=#87AFAF gui=none
hi Conceal ctermfg=77 ctermbg=234 cterm=none guifg=#5FD75F guibg=#262626 gui=none
" hi Noise ctermfg=247 ctermbg=234 cterm=none guifg=#9E9E9E guibg=#262626 gui=none
" Brackets
hi Noise ctermfg=159 ctermbg=234 cterm=bold guifg=#9E9E9E guibg=#262626 gui=none
hi helpHyperTextJump ctermfg=74 ctermbg=234 cterm=none guifg=#5FAFD7 guibg=#262626 gui=none
hi perlSharpBang ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none
hi rubySharpBang ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none
" hi jsFuncCall ctermfg=117 ctermbg=234 cterm=none guifg=#87D7D7 guibg=#262626 gui=none
hi jsFuncCall ctermfg=111 ctermbg=234 cterm=none guifg=#87D7D7 guibg=#262626 gui=none

" Html
hi javaScriptNumber ctermfg=179 ctermbg=234 cterm=none guifg=#D7AF5F guibg=#262626 gui=none
hi htmlTag ctermfg=147 ctermbg=234 cterm=none guifg=#AFAFFF guibg=#262626 gui=none
hi htmlEndTag ctermfg=147 ctermbg=234 cterm=none guifg=#AFAFFF guibg=#262626 gui=none
hi htmlTagName ctermfg=175 ctermbg=234 cterm=none guifg=#D787AF guibg=#262626 gui=none
hi htmlString ctermfg=187 ctermbg=234 cterm=none guifg=#D7D7AF guibg=#262626 gui=none

" Vim
hi vimFold ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none
hi vimCommentTitle ctermfg=249 ctermbg=234 cterm=none guifg=#B2B2B2 guibg=#262626 gui=none

" Diff File
hi diffFile ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none
hi diffLine ctermfg=186 ctermbg=234 cterm=none guifg=#D7D787 guibg=#262626 gui=none
hi diffAdded ctermfg=107 ctermbg=234 cterm=none guifg=#87AF5F guibg=#262626 gui=none
hi diffRemoved ctermfg=175 ctermbg=234 cterm=none guifg=#D787AF guibg=#262626 gui=none
hi diffChanged ctermfg=179 ctermbg=234 cterm=none guifg=#D7AF5F guibg=#262626 gui=none
hi diffSubname ctermfg=252 ctermbg=234 cterm=none guifg=#D0D0D0 guibg=#262626 gui=none
hi diffOldLine ctermfg=104 ctermbg=234 cterm=none guifg=#8787D7 guibg=#262626 gui=none

" Mail
hi mailSubject ctermfg=109 ctermbg=234 cterm=none guifg=#87AFAF guibg=#262626 gui=none
hi mailSignature ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none

" Markdown
hi markdownCode ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none
hi markdownCodeBlock ctermfg=244 ctermbg=234 cterm=none guifg=#808080 guibg=#262626 gui=none
hi markdownItalic ctermfg=252 ctermbg=234 cterm=none guifg=#D0D0D0 guibg=#262626 gui=none

" Vim color file
"
"  "    __       _ _       _                             "
"  "    \ \  ___| | |_   _| |__   ___  __ _ _ __  ___    "
"  "     \ \/ _ \ | | | | |  _ \ / _ \/ _  |  _ \/ __|   "
"  "  /\_/ /  __/ | | |_| | |_| |  __/ |_| | | | \__ \   "
"  "  \___/ \___|_|_|\__  |____/ \___|\____|_| |_|___/   "
"  "                 \___/                               "
"
"         "A colorful, dark color scheme for Vim."
"
" File:         jellybeans.vim
" URL:          github.com/nanotech/jellybeans.vim
" Scripts URL:  vim.org/scripts/script.php?script_id=2555
" Maintainer:   NanoTech (nanotech.nanotechcorp.net)
" Version:      1.6~git
" Last Change:  January 15th, 2012
" License:      MIT
" Contributors: Daniel Herbert (pocketninja)
"               Henry So, Jr. <henryso@panix.com>
"               David Liang <bmdavll at gmail dot com>
"               Rich Healey (richo)
"               Andrew Wong (w0ng)
"
" Copyright (c) 2009-2012 NanoTech
"
" Permission is hereby granted, free of charge, to any per‐
" son obtaining a copy of this software and associated doc‐
" umentation  files  (the “Software”), to deal in the Soft‐
" ware without restriction,  including  without  limitation
" the rights to use, copy, modify, merge, publish, distrib‐
" ute, sublicense, and/or sell copies of the Software,  and
" to permit persons to whom the Software is furnished to do
" so, subject to the following conditions:
"
" The above copyright notice  and  this  permission  notice
" shall  be  included in all copies or substantial portions
" of the Software.
"
" THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY
" KIND,  EXPRESS  OR  IMPLIED, INCLUDING BUT NOT LIMITED TO
" THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICU‐
" LAR  PURPOSE  AND  NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE  LIABLE  FOR  ANY  CLAIM,
" DAMAGES  OR OTHER LIABILITY, WHETHER IN AN ACTION OF CON‐
" TRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON‐
" NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "jellybeans"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  let s:low_color = 0
else
  let s:low_color = 1
endif

" Color approximation functions by Henry So, Jr. and David Liang {{{
" Added to jellybeans.vim by Daniel Herbert

" returns an approximate grey index for the given grey level
fun! s:grey_number(x)
  if &t_Co == 88
    if a:x < 23
      return 0
    elseif a:x < 69
      return 1
    elseif a:x < 103
      return 2
    elseif a:x < 127
      return 3
    elseif a:x < 150
      return 4
    elseif a:x < 173
      return 5
    elseif a:x < 196
      return 6
    elseif a:x < 219
      return 7
    elseif a:x < 243
      return 8
    else
      return 9
    endif
  else
    if a:x < 14
      return 0
    else
      let l:n = (a:x - 8) / 10
      let l:m = (a:x - 8) % 10
      if l:m < 5
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" returns the actual grey level represented by the grey index
fun! s:grey_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 46
    elseif a:n == 2
      return 92
    elseif a:n == 3
      return 115
    elseif a:n == 4
      return 139
    elseif a:n == 5
      return 162
    elseif a:n == 6
      return 185
    elseif a:n == 7
      return 208
    elseif a:n == 8
      return 231
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 8 + (a:n * 10)
    endif
  endif
endfun

" returns the palette index for the given grey index
fun! s:grey_color(n)
  if &t_Co == 88
    if a:n == 0
      return 16
    elseif a:n == 9
      return 79
    else
      return 79 + a:n
    endif
  else
    if a:n == 0
      return 16
    elseif a:n == 25
      return 231
    else
      return 231 + a:n
    endif
  endif
endfun

" returns an approximate color index for the given color level
fun! s:rgb_number(x)
  if &t_Co == 88
    if a:x < 69
      return 0
    elseif a:x < 172
      return 1
    elseif a:x < 230
      return 2
    else
      return 3
    endif
  else
    if a:x < 75
      return 0
    else
      let l:n = (a:x - 55) / 40
      let l:m = (a:x - 55) % 40
      if l:m < 20
        return l:n
      else
        return l:n + 1
      endif
    endif
  endif
endfun

" returns the actual color level for the given color index
fun! s:rgb_level(n)
  if &t_Co == 88
    if a:n == 0
      return 0
    elseif a:n == 1
      return 139
    elseif a:n == 2
      return 205
    else
      return 255
    endif
  else
    if a:n == 0
      return 0
    else
      return 55 + (a:n * 40)
    endif
  endif
endfun

" returns the palette index for the given R/G/B color indices
fun! s:rgb_color(x, y, z)
  if &t_Co == 88
    return 16 + (a:x * 16) + (a:y * 4) + a:z
  else
    return 16 + (a:x * 36) + (a:y * 6) + a:z
  endif
endfun

" returns the palette index to approximate the given R/G/B color levels
fun! s:color(r, g, b)
  " get the closest grey
  let l:gx = s:grey_number(a:r)
  let l:gy = s:grey_number(a:g)
  let l:gz = s:grey_number(a:b)

  " get the closest color
  let l:x = s:rgb_number(a:r)
  let l:y = s:rgb_number(a:g)
  let l:z = s:rgb_number(a:b)

  if l:gx == l:gy && l:gy == l:gz
    " there are two possibilities
    let l:dgr = s:grey_level(l:gx) - a:r
    let l:dgg = s:grey_level(l:gy) - a:g
    let l:dgb = s:grey_level(l:gz) - a:b
    let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
    let l:dr = s:rgb_level(l:gx) - a:r
    let l:dg = s:rgb_level(l:gy) - a:g
    let l:db = s:rgb_level(l:gz) - a:b
    let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
    if l:dgrey < l:drgb
      " use the grey
      return s:grey_color(l:gx)
    else
      " use the color
      return s:rgb_color(l:x, l:y, l:z)
    endif
  else
    " only one possibility
    return s:rgb_color(l:x, l:y, l:z)
  endif
endfun

" returns the palette index to approximate the 'rrggbb' hex string
fun! s:rgb(rgb)
  let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0
  return s:color(l:r, l:g, l:b)
endfun

" sets the highlighting for the given group
fun! s:X(group, fg, bg, attr, lcfg, lcbg)
  if s:low_color
    let l:fge = empty(a:lcfg)
    let l:bge = empty(a:lcbg)

    if !l:fge && !l:bge
      exec "hi ".a:group." ctermfg=".a:lcfg." ctermbg=".a:lcbg
    elseif !l:fge && l:bge
      exec "hi ".a:group." ctermfg=".a:lcfg." ctermbg=NONE"
    elseif l:fge && !l:bge
      exec "hi ".a:group." ctermfg=NONE ctermbg=".a:lcbg
    endif
  else
    let l:fge = empty(a:fg)
    let l:bge = empty(a:bg)

    if !l:fge && !l:bge
      exec "hi ".a:group." guifg=#".a:fg." guibg=#".a:bg." ctermfg=".s:rgb(a:fg)." ctermbg=".s:rgb(a:bg)
    elseif !l:fge && l:bge
      exec "hi ".a:group." guifg=#".a:fg." guibg=NONE ctermfg=".s:rgb(a:fg)." ctermbg=NONE"
    elseif l:fge && !l:bge
      exec "hi ".a:group." guifg=NONE guibg=#".a:bg." ctermfg=NONE ctermbg=".s:rgb(a:bg)
    endif
  endif

  if a:attr == ""
    exec "hi ".a:group." gui=none cterm=none"
  else
    let l:noitalic = join(filter(split(a:attr, ","), "v:val !=? 'italic'"), ",")
    if empty(l:noitalic)
      let l:noitalic = "none"
    endif
    exec "hi ".a:group." gui=".a:attr." cterm=".l:noitalic
  endif
endfun
" }}}

if !exists("g:jellybeans_background_color")
  let g:jellybeans_background_color = "151515"
end

call s:X("Normal","e8e8d3",g:jellybeans_background_color,"","White","")
set background=dark

if !exists("g:jellybeans_use_lowcolor_black") || g:jellybeans_use_lowcolor_black
    let s:termBlack = "Black"
else
    let s:termBlack = "Grey"
endif

if version >= 700
  call s:X("CursorLine","","1c1c1c","","",s:termBlack)
  call s:X("CursorColumn","","1c1c1c","","",s:termBlack)
  call s:X("MatchParen","ffffff","556779","bold","","DarkCyan")

  call s:X("TabLine","000000","b0b8c0","italic","",s:termBlack)
  call s:X("TabLineFill","9098a0","","","",s:termBlack)
  call s:X("TabLineSel","000000","f0f0f0","italic,bold",s:termBlack,"White")

  " Auto-completion
  call s:X("Pmenu","ffffff","606060","","White",s:termBlack)
  call s:X("PmenuSel","101010","eeeeee","",s:termBlack,"White")
endif

call s:X("Visual","","404040","","",s:termBlack)
call s:X("Cursor",g:jellybeans_background_color,"b0d0f0","","","")

call s:X("LineNr","605958",g:jellybeans_background_color,"none",s:termBlack,"")
call s:X("CursorLineNr","ccc5c4","","none","White","")
call s:X("Comment","888888","","italic","Grey","")
call s:X("Todo","c7c7c7","","bold","White",s:termBlack)

call s:X("StatusLine","000000","dddddd","italic","","White")
call s:X("StatusLineNC","ffffff","403c41","italic","White","Black")
call s:X("VertSplit","777777","403c41","",s:termBlack,s:termBlack)
call s:X("WildMenu","f0a0c0","302028","","Magenta","")

call s:X("Folded","a0a8b0","384048","italic",s:termBlack,"")
call s:X("FoldColumn","535D66","1f1f1f","","",s:termBlack)
call s:X("SignColumn","777777","333333","","",s:termBlack)
call s:X("ColorColumn","","000000","","",s:termBlack)

call s:X("Title","70b950","","bold","Green","")

call s:X("Constant","cf6a4c","","","Red","")
call s:X("Special","799d6a","","","Green","")
call s:X("Delimiter","668799","","","Grey","")

call s:X("String","99ad6a","","","Green","")
call s:X("StringDelimiter","556633","","","DarkGreen","")

call s:X("Identifier","c6b6ee","","","LightCyan","")
call s:X("Structure","8fbfdc","","","LightCyan","")
call s:X("Function","fad07a","","","Yellow","")
call s:X("Statement","8197bf","","","DarkBlue","")
call s:X("PreProc","8fbfdc","","","LightBlue","")

hi! link Operator Structure

call s:X("Type","ffb964","","","Yellow","")
call s:X("NonText","606060",g:jellybeans_background_color,"",s:termBlack,"")

call s:X("SpecialKey","444444","1c1c1c","",s:termBlack,"")

call s:X("Search","f0a0c0","302028","underline","Magenta","")

call s:X("Directory","dad085","","","Yellow","")
call s:X("ErrorMsg","","902020","","","DarkRed")
hi! link Error ErrorMsg
hi! link MoreMsg Special
call s:X("Question","65C254","","","Green","")


" Spell Checking

call s:X("SpellBad","","902020","underline","","DarkRed")
call s:X("SpellCap","","0000df","underline","","Blue")
call s:X("SpellRare","","540063","underline","","DarkMagenta")
call s:X("SpellLocal","","2D7067","underline","","Green")

" Diff

hi! link diffRemoved Constant
hi! link diffAdded String

" VimDiff

call s:X("DiffAdd","D2EBBE","437019","","White","DarkGreen")
call s:X("DiffDelete","40000A","700009","","DarkRed","DarkRed")
call s:X("DiffChange","","2B5B77","","White","DarkBlue")
call s:X("DiffText","8fbfdc","000000","reverse","Yellow","")

" PHP

hi! link phpFunctions Function
call s:X("StorageClass","c59f6f","","","Red","")
hi! link phpSuperglobal Identifier
hi! link phpQuoteSingle StringDelimiter
hi! link phpQuoteDouble StringDelimiter
hi! link phpBoolean Constant
hi! link phpNull Constant
hi! link phpArrayPair Operator
hi! link phpOperator Normal
hi! link phpRelation Normal
hi! link phpVarSelector Identifier

" Python

hi! link pythonOperator Statement

" Ruby

hi! link rubySharpBang Comment
call s:X("rubyClass","447799","","","DarkBlue","")
call s:X("rubyIdentifier","c6b6fe","","","Cyan","")
hi! link rubyConstant Type
hi! link rubyFunction Function

call s:X("rubyInstanceVariable","c6b6fe","","","Cyan","")
call s:X("rubySymbol","7697d6","","","Blue","")
hi! link rubyGlobalVariable rubyInstanceVariable
hi! link rubyModule rubyClass
call s:X("rubyControl","7597c6","","","Blue","")

hi! link rubyString String
hi! link rubyStringDelimiter StringDelimiter
hi! link rubyInterpolationDelimiter Identifier

call s:X("rubyRegexpDelimiter","540063","","","Magenta","")
call s:X("rubyRegexp","dd0093","","","DarkMagenta","")
call s:X("rubyRegexpSpecial","a40073","","","Magenta","")

call s:X("rubyPredefinedIdentifier","de5577","","","Red","")

" Erlang

hi! link erlangAtom rubySymbol
hi! link erlangBIF rubyPredefinedIdentifier
hi! link erlangFunction rubyPredefinedIdentifier
hi! link erlangDirective Statement
hi! link erlangNode Identifier

" JavaScript

hi! link javaScriptValue Constant
hi! link javaScriptRegexpString rubyRegexp

" CoffeeScript

hi! link coffeeRegExp javaScriptRegexpString

" Lua

hi! link luaOperator Conditional

" C

hi! link cFormat Identifier
hi! link cOperator Constant

" Objective-C/Cocoa

hi! link objcClass Type
hi! link cocoaClass objcClass
hi! link objcSubclass objcClass
hi! link objcSuperclass objcClass
hi! link objcDirective rubyClass
hi! link objcStatement Constant
hi! link cocoaFunction Function
hi! link objcMethodName Identifier
hi! link objcMethodArg Normal
hi! link objcMessageName Identifier

" Vimscript

hi! link vimOper Normal

" Debugger.vim

call s:X("DbgCurrent","DEEBFE","345FA8","","White","DarkBlue")
call s:X("DbgBreakPt","","4F0037","","","DarkMagenta")

" vim-indent-guides

if !exists("g:indent_guides_auto_colors")
  let g:indent_guides_auto_colors = 0
endif
call s:X("IndentGuidesOdd","","232323","","","")
call s:X("IndentGuidesEven","","1b1b1b","","","")

" Plugins, etc.

hi! link TagListFileName Directory
call s:X("PreciseJumpTarget","B9ED67","405026","","White","Green")

if !exists("g:jellybeans_background_color_256")
  let g:jellybeans_background_color_256=233
end
" Manual overrides for 256-color terminals. Dark colors auto-map badly.
if !s:low_color
  hi StatusLineNC ctermbg=235
  hi Folded ctermbg=236
  hi FoldColumn ctermbg=234
  hi SignColumn ctermbg=236
  hi CursorColumn ctermbg=234
  hi CursorLine ctermbg=234
  hi SpecialKey ctermbg=234
  exec "hi NonText ctermbg=".g:jellybeans_background_color_256
  exec "hi LineNr ctermbg=".g:jellybeans_background_color_256
  hi DiffText ctermfg=81
  exec "hi Normal ctermbg=".g:jellybeans_background_color_256
  hi DbgBreakPt ctermbg=53
  hi IndentGuidesOdd ctermbg=235
  hi IndentGuidesEven ctermbg=234
endif

if exists("g:jellybeans_overrides")
  fun! s:load_colors(defs)
    for [l:group, l:v] in items(a:defs)
      call s:X(l:group, get(l:v, 'guifg', ''), get(l:v, 'guibg', ''),
      \                 get(l:v, 'attr', ''),
      \                 get(l:v, 'ctermfg', ''), get(l:v, 'ctermbg', ''))
      if !s:low_color
        for l:prop in ['ctermfg', 'ctermbg']
          let l:override_key = '256'.l:prop
          if has_key(l:v, l:override_key)
            exec "hi ".l:group." ".l:prop."=".l:v[l:override_key]
          endif
        endfor
      endif
      unlet l:group
      unlet l:v
    endfor
  endfun
  call s:load_colors(g:jellybeans_overrides)
  delf s:load_colors
endif

" delete functions {{{
delf s:X
delf s:rgb
delf s:color
delf s:rgb_color
delf s:rgb_level
delf s:rgb_number
delf s:grey_color
delf s:grey_level
delf s:grey_number
" }}}
"
hi jsFuncCall ctermfg=111 ctermbg=234 cterm=none guifg=#87D7D7 guibg=#262626 gui=none
" this
hi Special ctermfg=221 ctermbg=234 cterm=bold guifg=#D78787 guibg=#262626 gui=none
" $ sign in jquery
hi Constant ctermfg=221 ctermbg=234 cterm=bold guifg=#D7D787 guibg=#262626 gui=none
" numbers
hi Number ctermfg=202 ctermbg=234 cterm=none guifg=#D7AF87 guibg=#262626 gui=none
" Variable Name
hi Identifier ctermfg=183 ctermbg=234 cterm=none guifg=#D7AFD7 guibg=#262626 gui=none

"function name
hi Function ctermfg=111 ctermbg=234 cterm=bold guifg=#D7AFD7 guibg=#262626 gui=none
" if
hi Conditional ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Repeat ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Label ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Operator ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Keyword ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi Exception ctermfg=183 ctermbg=234 cterm=bold guifg=#87AFD7 guibg=#262626 gui=none
hi PreProc ctermfg=111 ctermbg=234 cterm=none guifg=#AFD787 guibg=#262626 gui=none
" function
hi Type ctermfg=183 ctermbg=234 cterm=bold guifg=#AFAFD7 guibg=#262626 gui=none
" var
hi StorageClass ctermfg=183 ctermbg=234 cterm=bold guifg=#AFAFD7 guibg=#262626 gui=none
hi Noise ctermfg=159 ctermbg=234 cterm=bold guifg=#9E9E9E guibg=#262626 gui=none
" hi jsFuncCall ctermfg=117 ctermbg=234 cterm=none guifg=#87D7D7 guibg=#262626 gui=none
hi jsFuncCall ctermfg=111 ctermbg=234 cterm=none guifg=#87D7D7 guibg=#262626 gui=none

" $("string")
hi String ctermfg=193 ctermbg=234 cterm=none guifg=#D7D7AF guibg=#262626 gui=none
hi htmlTagName ctermfg=111 ctermbg=234 cterm=bold guifg=#D787AF guibg=#262626 gui=none
hi Todo ctermfg=202 ctermbg=236 cterm=bold guifg=#808080 guibg=#262626 gui=none

set clipboard+=unnamedplus

nnoremap <C-j> 10<C-e>
nnoremap <C-k> 10<C-y>
map <Leader>h :tabprevious<cr>
map <Leader>l :tabnext<cr>
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" open Terminal with <C-t>
set splitright
function! OpenTerminal()
  " move to right most buffer
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"
  execute "normal \<C-l>"

  let bufNum = bufnr("%")
  let bufType = getbufvar(bufNum, "&buftype", "not found")

  if bufType == "terminal"
    " close existing terminal
    execute "q"
  else
    " open terminal
    execute "vsp term://zsh"

    " turn off numbers
    execute "set nonu"
    execute "set nornu"

    " toggle insert on enter/exit
    silent au BufLeave <buffer> stopinsert!
    silent au BufWinEnter,WinEnter <buffer> startinsert!

    " set maps inside terminal buffer
    execute "tnoremap <buffer> <C-h> <C-\\><C-n><C-w><C-h>"
    execute "tnoremap <buffer> <C-t> <C-\\><C-n>:q<CR>"
    execute "tnoremap <buffer> <C-\\><C-\\> <C-\\><C-n>"

    startinsert!
  endif
endfunction

" inoremap <expr> <CR> ParensIndent()

" function! ParensIndent()
"   let prev = col('.') - 1
"   let after = col('.')
"   let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
"   let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
"   if (prevChar == '"' && afterChar == '"') ||
" \    (prevChar == "'" && afterChar == "'") ||
" \    (prevChar == "(" && afterChar == ")") ||
" \    (prevChar == "{" && afterChar == "}") ||
" \    (prevChar == "[" && afterChar == "]")
"     return "\<CR>\<ESC>O"
"   endif
  
"   return "\<CR>"
" endfunction

" inoremap <expr> <space> ParensSpacing()

" function! ParensSpacing()
"   let prev = col('.') - 1
"   let after = col('.')
"   let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
"   let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
"   if (prevChar == '"' && afterChar == '"') ||
" \    (prevChar == "'" && afterChar == "'") ||
" \    (prevChar == "(" && afterChar == ")") ||
" \    (prevChar == "{" && afterChar == "}") ||
" \    (prevChar == "[" && afterChar == "]")
"     return "\<space>\<space>\<left>"
"   endif
  
"   return "\<space>"
" endfunction

" inoremap <expr> <BS> ParensRemoveSpacing()

" function! ParensRemoveSpacing()
"   let prev = col('.') - 1
"   let after = col('.')
"   let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
"   let afterChar = matchstr(getline('.'), '\%' . after . 'c.')

"   if (prevChar == '"' && afterChar == '"') ||
" \    (prevChar == "'" && afterChar == "'") ||
" \    (prevChar == "(" && afterChar == ")") ||
" \    (prevChar == "{" && afterChar == "}") ||
" \    (prevChar == "[" && afterChar == "]")
"     return "\<bs>\<right>\<bs>"
"   endif
  
"   if (prevChar == ' ' && afterChar == ' ')
"     let prev = col('.') - 2
"     let after = col('.') + 1
"     let prevChar = matchstr(getline('.'), '\%' . prev . 'c.')
"     let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
"     if (prevChar == '"' && afterChar == '"') ||
"   \    (prevChar == "'" && afterChar == "'") ||
"   \    (prevChar == "(" && afterChar == ")") ||
"   \    (prevChar == "{" && afterChar == "}") ||
"   \    (prevChar == "[" && afterChar == "]")
"       return "\<bs>\<right>\<bs>"
"     endif
"   endif
  
"   return "\<bs>"
" endfunction
" inoremap { {}<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap ' ''<left>
" inoremap " ""<left>

" let curly = "}"
" inoremap <expr> } CheckNextParens(curly)

" let bracket = "]"
" inoremap <expr> ] CheckNextParens(bracket)

" let parens = ")"
" inoremap <expr> ) CheckNextParens(parens)

" let quote = "'"
" inoremap <expr> ' CheckNextQuote(quote)

" let dquote = '"'
" inoremap <expr> " CheckNextQuote(dquote)

" let bticks = '`'
" inoremap <expr> ` CheckNextQuote(bticks)

" function CheckNextQuote(c)
"   let after = col('.')
"   let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
  
"   if (afterChar == a:c)
"     return "\<right>"
"   endif
"   if (afterChar == ' ' || afterChar == '' || afterChar == ')' || afterChar== '}' || afterChar == ']')
"     return a:c . a:c . "\<left>"
"   endif
"   if (afterChar != a:c)
"     let bticks = '`'
"     let dquote = '"'
"     let quote = "'"
"     if(afterChar == dquote || afterChar == quote || afterChar == bticks)
"       return a:c . a:c . "\<left>"
"     endif
"   endif
"   return a:c
" endfunction

" function CheckNextParens(c)
"   let after = col('.')
"   let afterChar = matchstr(getline('.'), '\%' . after . 'c.')
"   if (afterChar == a:c)

"     return "\<right>"
"   endif
"   return a:c
" endfunction

set clipboard+=unnamedplus
let g:coc_global_extensions = ['coc-marketplace']
function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction
  " Insert <tab> when previous text is space, refresh completion if not.
  inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#_select_confirm() :
    \ coc#expandableOrJumpable() ?
    \ "\<C-r>=coc#rpc#request('doKeymap',''])\<CR>" :
    \ CheckBackSpace() ? "\<TAB>" :
    \ coc#refresh()

  function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
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

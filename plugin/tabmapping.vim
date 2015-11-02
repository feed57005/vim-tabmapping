" tabmapping.vim - plugin for smart tab mapping ala tmux/screen
" Maintainer:   Pavel Novy
" Version:      0.1

if exists('g:loaded_tabmapping') || &cp
  finish
endif
let g:loaded_tabmapping = 1

let s:current_tab = 1
let s:prev_tab = 1

function! s:TabLeave() abort
  let tabs_count = tabpagenr('$')
  let s:prev_tab = tabpagenr()
endfunction

function! s:TabEnter() abort
  let s:current_tab = tabpagenr()
  let tabs_count = tabpagenr('$')
  if s:prev_tab > tabs_count
    let s:prev_tab = tabs_count
  endif
  if s:current_tab == s:prev_tab
    let tabs_count = tabpagenr('$')
    if tabs_count == 1
      return
    else
      let s:prev_tab = s:current_tab - 1
    endif
  endif
endfunction

autocmd TabLeave * call s:TabLeave()
autocmd TabEnter * call s:TabEnter()

function! tabmapping#Toggle() abort
  silent execute ":normal ".s:prev_tab."gt"
endfunction

function! tabmapping#Goto(n) abort
  let tab_id = a:n
  let tabs_count = tabpagenr('$')
  if tab_id > tabs_count
    let tab_id = tabs_count
  endif
  silent execute ":normal ".tab_id."gt"
endfunction

map <leader>tt :execute tabmapping#Toggle()<CR>
map <leader>t1 :execute tabmapping#Goto(1)<CR>
map <leader>t2 :execute tabmapping#Goto(2)<CR>
map <leader>t3 :execute tabmapping#Goto(3)<CR>
map <leader>t4 :execute tabmapping#Goto(4)<CR>
map <leader>t5 :execute tabmapping#Goto(5)<CR>
map <leader>t6 :execute tabmapping#Goto(6)<CR>
map <leader>t7 :execute tabmapping#Goto(7)<CR>
map <leader>t8 :execute tabmapping#Goto(8)<CR>
map <leader>t9 :execute tabmapping#Goto(9)<CR>
map <leader>tc :tabnew<CR>
map <leader>tx :tabclose<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>

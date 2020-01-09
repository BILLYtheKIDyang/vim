finish
function! FindOpen(open, close, linnum, colnum)  "(
   let [open, close, linnum, colnum] = [a:open, a:close, a:linnum, a:colnum]
   if linnum < 0
      return [0,0]
   endif "
   let line = getline(linnum)
   for i in range(colnum, 0, -1)
      if line[i] == close
         let [l, c] =  FindOpen(open, close, linnum, i-1)
         return FindOpen(open, close, l, c-1)
      elseif line[i] == open
         return [linnum, i]
      endif
   endfor
   return FindOpen(open, close, linnum-1, len(getline(linnum-1)))
endfunction
function! InsertClose(close)
   if a:close == ')'
      let [l,c] = FindOpen('(', a:close, getpos('.')[1], getpos('.')[2])
      if l 
         echo getline(l)[c:c+20]
         exec "normal! a)"
      endif
   elseif a:close == ']'
      let [l,c] = FindOpen('[', a:close, getpos('.')[1], getpos('.')[2])
      if l
         echo getline(l)[c:c+20]
         exec "normal! a]"
      endif
   elseif a:close == ' '
      let [l,c] = FindOpen('(', ')', getpos('.')[1], getpos('.')[2])
      if l
         return getline(l)[c+1:]
      endif
   endif
endfunction
function! GetFunctionName()
   
endfunction
function! GetNonLispDoc()
endfunction
function! GetLispDoc()
   let  funname_ = split(trim(InsertClose(' ')), '[ \t\n]')
   if len(funname_) == 0
      return ''
   endif
   let  funname = split(trim(InsertClose(' ')), '[ \t\n]')[0]
   if has_key(g:Complete_dict, funname)
      echo keys(g:Complete_dict[funname])[0]
   endif
endfunction
augroup lisp
   autocmd!
   autocmd FileType clojure,lisp,scheme,racket,emacs-lisp inoremap ) <Esc>:call InsertClose(')') <CR>a
   autocmd FileType clojure,lisp,scheme,racket,emacs-lisp inoremap ] <Esc>:call InsertClose(']') <CR>a
   autocmd FileType clojure,lisp,scheme,racket,emacs-lisp inoremap   <Esc>:call GetLispDoc() <CR>a<Space>
augroup END

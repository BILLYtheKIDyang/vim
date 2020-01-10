if exists('g:loaded_GetLispIndent')
   finish
endif
let g:loaded_GetLispIndent = 1

function! GetLispIndent(lnum)
   set lispwords=
   for n in range(a:lnum - 2, a:lnum - 1)
      let line = getline(n)
      let words = split(line, "(\\+\\|\\[\\+\\|\\]\\+\\|)\\+\\| \\+\\|\\t\\+")
      let words = map(words, 'trim(v:val, "()[]")')
      for lp in words
         if len(lp) > 1 && index(split(g:LispIndentKeep, ';'), lp) == -1 
            execute ":set lispwords+=" . lp
         endif
      endfor
   endfor
   return lispindent(line('.'))
endfunction
let g:LispIndentKeep = 'if;and;or'

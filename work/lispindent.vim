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

function! LispIndent()
   let [l, c] = FindOpen('(', ')', v:lnum-1, len(getline(v:lnum-1)))
   echom v:lnum l
   if !(l + c)
      return 0
   else
      return c + 3
   endif
endfunction

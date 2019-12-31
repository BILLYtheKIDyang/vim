let g:CompleteData = []
for key in keys(g:Complete_dict)
   call add(g:CompleteData, [key, g:Complete_dict[key]])
endfor
function! Strcmp(s1, s2)
   let s1 = a:s1
   let s2 = a:s2
   let k1 = len(s1)
   let k2 = len(s2)
   for i in range(min([k1, k2]))
      if (s1[i] - s2[i])
         return s1[i] - s2[i]
      endif
   endfor
   return k1 - k2
endfunction
function! CompareBy(itm1, itm2)
   return Strcmp(a:itm1[1] , a:itm2[1])
endfunction

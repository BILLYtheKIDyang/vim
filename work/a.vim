function! Increase(k, n)
   let k = a:k
   let n = a:n
   if (k + 1) * (k + 1) > n
      return k
   else
      return k + 1
   endif
endfunction

function! Introot(n)
   let n = a:n
   if n < 1
      return 0
   else
      return Increase(2 * Introot(n / 4), n)
   endif
endfunction

let s:count = 0
function! Introot(n)
   let s:count = s:count + 1
   echo s:count

   let n = a:n
   if n < 1
      return 0
   else
      let m = Introot(n / 4) 
      if ((2 * m) + 1) * ((2 * m) + 1) > n
         return 2 * m
      else
         return 2 * m + 1
      endif
   endif
endfunction

echo Introot(1234567890)

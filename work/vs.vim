function! Sqrt(n)
   let n = a:n

   function! Iter(x) closure
      let x = a:x
      let y = (n / x + x) / 2.0
      if x == y
         return x
      else
         return Iter(y)
      endif
   endfunction
   return Iter(1)
endfunction

for i in range(1,100)
   let S = Sqrt(i)
   let s = sqrt(i)
   if s != S
      echo s S
   endif
endfor

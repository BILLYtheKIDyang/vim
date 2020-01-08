function! Sqrt(n)
   let n = a:n
   function! Iter(x) closure
      let x = a:x
      let y = (x + n / x) / 2 
      if x == y
         return x
      else
         return Iter(y)
      endif
   endfunction
   return Iter(1.0)
endfunction

echo Sqrt(100)
echo Sqrt(10)
echo Sqrt(9)

let lnum = 1
while lnum <= line("$")
   let lnum += 1
endwhile

function Fact(n)
   let n = a:n
   if n < 2
      return 1
   else
      return n * Fact(n - 1)
   endif
endfunction

echo Fact(33)

echo sin(33)

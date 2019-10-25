function fact(n)
   if n < 2 then
      fact = 1
   else
      fact = n * fact(n - 1)
   end if
end function

CreateObject("SAPI.SpVoice").speak "问问"

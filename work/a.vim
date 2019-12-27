for c in reverse(getcompletion('', "color"))
   redraw!
   echo c
   try 
      exec "colo " .. c
   catch
   endtry
   sleep 1 
endfor

for c in reverse(getcompletion('', "color"))
  redraw!
  colo default
  sleep 1
  redraw!
  echo c
  try 
    exec "colo " .. c
  catch
  endtry
  sleep 1 
endfor

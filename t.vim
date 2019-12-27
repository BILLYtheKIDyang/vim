for color in  split( expand("~/.vim/colors/*"), "\n")
   let name = split(split(color, "\\")[-1], "\\.")[0]
   redraw
   echo name
   try 
      exec "colorscheme " . name
   catch
   endtry
   sleep 3
endfor

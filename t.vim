for color in  split( expand("~/.vim/colors/*"), "\n")
   let name = split(split(color, "\\")[-1], "\\.")[0]
   redraw
   echo name
   exec "colorscheme " . name
   sleep 3
endfor

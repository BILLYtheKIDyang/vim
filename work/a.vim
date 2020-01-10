for line in getline(1, 20)
   if line =~ 'Date: '
      echo matchstr(line, 'Date: \zs.*')
   endif
endfor

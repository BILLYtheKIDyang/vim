set lisp
let x = {}
for line in readfile(expand("~/.vim/chez.scm"))
   let name = trim(matchstr(line, '^(\(\S\+\)'), '(')
   if has_key(x, name)
      let x[name][line] = '' 
   else
      let x[name] = {}
      let x[name][line] = ''
   endif
endfor
let y = []
for name in sort(keys(x))
   let s = name . ';'  
   for k in sort(keys(x[name]), { x,y -> len(x) - len(y)})
      let s = s .. ' ' .. k
   endfor
   call add(y, s)
endfor
call writefile(y, expand("~/.MyComplete"))
call M()

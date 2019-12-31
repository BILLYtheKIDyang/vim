let g:Complete_dict = {}
for e in map(getcompletion('', 'expression'), 'split(v:val, "(")[0] .. ";" .. "expression"')
   let [name, type] = split(e, ";")
   let g:Complete_dict[ name ] = type
endfor

let g:funargs=''
redir => g:funargs
:silent function
redir END
for fd in split(g:fundoc, "\n")
   let t = split(fd[9:], '(')
   if len(t) > 1
      let g:Complete_dict[t[0]] = '(' .. t[1]
   end
endfor

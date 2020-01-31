function! Csug(file, out)
   let file = a:file
   let lines = readfile(file)

   let x = {}

   for line in lines
      if line =~ '<tr><td nowrap><tt>'
         let line = substitute(line, '<tr><td nowrap><tt>', '','')
         let line = substitute(line, '&amp;', '\&', 'g')
         let line = substitute(line, '&lt;', '<', 'g')
         let line = substitute(line, '&gt;', '>', 'g')
         let line = substitute(line, '&nbsp;', ' ', 'g')
         let line = substitute(line, '<i>', '', 'g')
         let line = substitute(line, '</i>', '', 'g')
         let line = substitute(line, '<sub>', '', 'g')
         let line = substitute(line, '</sub>', '', 'g')
         let line = substitute(line, '</tt></td><td>', ';', 'g')
         let line = substitute(line, '</td><td align=right><a href=.*$', '', 'g')
         let line = trim(line)
         let [form,type] = split(line, ';')
         let name = trim(matchstr(trim(form), '^(\(\S\+\)'), '(')
         "echo form name type
         if len(name) > 0
            if has_key(x, name)
               
               let x[name] = x[name] + [form]
            else
               let x[name] = [form]
            endif
         else
            let x[form] = [type]
         endif
      endif
   endfor
   let y = []
   for name in sort(keys(x))
      let doc = uniq(sort(x[name], {x,y -> len(x) - len(y)}))
      call add(y, printf("\t\\\"%s\": '%s',", name, join(doc)))
   endfor
   call writefile(['let SchemeDoc = {'] + y + ["\t\\}"], a:out)
   exec "so " .. a:out
endfunction

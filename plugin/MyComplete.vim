function! DictionaryAdd(dict, key, type, val)
   let [dict, key, type, val] = [a:dict, a:key, a:type, a:val]
   if has_key(dict, key)
      if has_key(dict[key], type)
         let dict[key][type] = val
      else
         let dict[key][type] = val
      endif
   else
      let dict[key] = {}
      let dict[key][type] = val
   endif
endfunction

function! GetCompleteMenu(d)
   let d = a:d
   let s = ''
   for key in keys(d)
      let s = key .. " " .. s
   endfor
   return trim(s)
endfunction

let g:Complete_dict = {}
fun! M()
   let g:Complete_dict = {}
   for line in readfile(expand("~/.MyComplete"))
      let t = split(line, ';')
      if len(t) > 1
         let [name;doc] = split(line, ';')
         call DictionaryAdd(g:Complete_dict, name, join(doc, ';'), '')
      endif
   endfor
endfun
fun! MyComplete(start, base)
   if a:start
      let line = getline('.')
      let start = col('.') - 1
      while start > 0 && (line[start - 1] =~ '\k' || line[start - 1] =~ "[-&]")
         let start -= 1
      endwhile
      return start
   else
      let base = a:base
      let res = []

      let new =  ['.*']
      for c in   split(base, '\zs')
         call add(new, c)
         call add(new, '.*')
      endfor
      for name in sort(keys(g:Complete_dict))
         if name =~ '^.*' .. base
            call add(res, { 'icase': 1, 'word': name, 'menu': printf("%s", GetCompleteMenu(g:Complete_dict[name])) } )
         endif
      endfor
      return res 
   endif
endfunction

"set omnifunc=MyComplete

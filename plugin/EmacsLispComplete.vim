let g:Complete_dict = {}
fun! M()
   let g:Complete_dict = {}
   for line in readfile(expand("~/.MyComplete"))
      let t = split(line, ';')
      if len(t) > 1
         let [name;doc] = split(line, ';')
         let g:Complete_dict[name] = join(doc, ';')
      endif
   endfor
endfun
fun! MyComplete(start, base)
   if a:start
      let line = getline('.')
      let start = col('.') - 1
      while start > 0 && line[start - 1] =~ '\k'
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
      "for symboldoc in sort(g:Complete_dict)
      for name in sort(keys(g:Complete_dict))
         if name =~ '^.*' .. base
            call add(res, { 'icase': 1, 'word': name, 'menu': g:Complete_dict[name] } )
         endif
      endfor
      return res 
   endif
endfunction
function! VimScriptCompleteCache()
   let types = []
   let types += ['arglist']
   let types += ['augroup']
   let types += ['buffer']
   let types += ['behave']
   let types += ['color']
   let types += ['command']
   let types += ['compiler']
   let types += ['cscope']
   let types += ['dir']
   let types += ['environment']
   let types += ['event']
   let types += ['expression']
   let types += ['file']
   let types += ['file_in_path']
   let types += ['filetype']
   let types += ['function']
   let types += ['help']
   let types += ['highlight']
   let types += ['history']
   let types += ['locale']
   let types += ['mapclear']
   let types += ['mapping']
   let types += ['menu']
   let types += ['messages']
   let types += ['option']
   let types += ['packadd']
   let types += ['shellcmd']
   let types += ['sign']
   let types += ['syntax']
   let types += ['syntime']
   let types += ['tag']
   let types += ['tag_listfiles']
   let types += ['user']
   let types += ['var']
   let g:Complete_dict = {}
   for type in types
      try
         for name in map(getcompletion('', type), 'split(v:val, "(")[0]')
            let g:Complete_dict[ name ] = type
         endfor
      catch 
      endtry
   endfor



   let funargs=''
   redir => funargs
   :silent function
   redir END
   for fd in split(funargs, "\n")
      let t = split(fd[9:], '(')
      if len(t) > 1
         let g:Complete_dict[t[0]] = '(' .. t[1]
      end
   endfor
endfunction


set omnifunc=MyComplete

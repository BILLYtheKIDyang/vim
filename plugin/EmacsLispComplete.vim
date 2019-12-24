function! SchemeCompleteCache()
   let g:Complete_data = systemlist("ss.cmd")
endfunction
function! EmacsLispCompleteCache()
   let g:Complete_data =systemlist("es.cmd")
endfunction
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
      for symboldoc in sort(g:Complete_data)
         let sd = split(trim(symboldoc), ",")
         if len(sd) > 0 && sd[0] =~ '^' .. base
            call add(res, {
                     \ 'icase': 1,
                     \ 'word': sd[0],
                     \ 'menu': join(sd[1:],''),
                     \ })
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
   let g:Complete_data = []
   for type in types
      try
         let g:Complete_data += map(getcompletion('', type), 'v:val . "," . type')
      catch 
      endtry
   endfor
endfunction

set omnifunc=MyComplete

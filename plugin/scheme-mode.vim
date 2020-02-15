let g:SchemeList = []
function! SchemeComplete(start, base) abort
   if a:start
      let line = getline('.')
      let start = col('.') - 1
      while start > 0 && IsSchemeWordChar(line[start - 1])
         let start -= 1
      endwhile
      return start
   else
      let base = escape(a:base, '~*\^$.')
      let res = []

      let needComplete = getline('.')[0] != ' ' && stridx(getline('.'), ' ', 1) == -1
      let needComplete = needComplete || len(g:SchemeList) == 0
      if needComplete
         echom "Systemlist...."
         if &ft == 'lisp'
            let g:splitstring = system('echo "(princ split-string)" | sbcl --noinform --noprint --load ' .. expand("~/.vim/sbclrc.lisp"))
            let g:SchemeList = systemlist('echo "(tags \"' .. SchemeFile() .. '\")" | sbcl --noinform --noprint --disable-debugger --load ' .. expand('~/.vim/sbclrc.lisp'))
         elseif &ft == 'scheme'
            let g:splitstring = system('echo "(display split-string)" | scheme -q ' .. expand('~/.vim/bin/ss.cmd'))
            let g:SchemeList = systemlist('echo "(tags \"' .. SchemeFile() .. '\")" | scheme -q ' .. expand('~/.vim/bin/ss.cmd'))
            "let g:splitstring = system('echo "(display split-string)" | kawa -- ' .. expand('~/.vim/bin/ss.cmd'))
            "let g:SchemeList = systemlist('echo "(tags \"' .. SchemeFile() .. '\")" | kawa -- ' .. expand('~/.vim/bin/ss.cmd'))
         elseif &ft == 'racket'
            let g:splitstring = ';'
            let g:SchemeList = systemlist('echo "(tags \"' .. SchemeFile() .. '\")" | racket')
         endif
      endif
      for nametype in g:SchemeList
         let nametype = split(nametype, g:splitstring)
         if len(nametype) < 1
            continue
         endif
         let [name; type] = nametype
         if name =~ '^.*' .. base
            let menu = join(type, '')
            if menu[0] == '('
               let g:SchemeDoc[name] = menu
            endif
            call add(res, { 'icase': 1, 'word': name, 'menu': join(type, '')} )
         endif
      endfor
      return res
   endif
endfunction
function! IsSchemeWordChar(char)
   let char = a:char
   if char == "'"
      return 0
   endif
   if char == '"'
      return 0
   endif
   if char == '('
      return 0
   endif
   if char == ')'
      return 0
   endif
   if char == '['
      return 0
   endif
   if char == ']'
      retur 0
   endif
   if char == ' '
      return 0
   endif
   if char == "\t"
      return 0
   endif
   if char == "\n"
      return 0
   endif
   if char == ';'
      return 0
   endif
   return 1
endfunction

function! SchemeFile()
   let schemefile = tempname()
   let lines = getbufline("%", 1, "$")
   call writefile(lines, schemefile)
   return schemefile
endfunction
function! GetSchemeDoc()
   let  funname_ = split(trim(InsertClose(' ')), '[ \t\n]')
   if len(funname_) == 0
      return ''
   endif
   let  funname = split(trim(InsertClose(' ')), '[ \t\n]')[0]
   if has_key(g:SchemeDoc, funname)
      echo g:SchemeDoc[funname]
   endif
endfunction
aug scheme
   au BufNewFile,BufRead *.scm,*.ss,*rkt,*.lisp setl omnifunc=SchemeComplete
   au FileType scheme,lisp inoremap <buffer>   <Esc>:call GetSchemeDoc() <CR>a<Space>
aug END

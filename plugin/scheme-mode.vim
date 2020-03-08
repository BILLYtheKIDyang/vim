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
      let res = []
      let base = a:base
      let base_len = len(base) - 1

      let needComplete = getline('.')[0] != ' ' && stridx(getline('.'), ' ', 1) == -1
      let needComplete = needComplete || len(g:SchemeList) == 0
      if needComplete
            let g:SchemeList = SchemeSymbols(SchemeFile())
            let g:SchemeListLength = len(g:SchemeList)
      endif

      if &ft == 'scheme'
         let i = g:SchemeListLength - 1
         while i >= 0
            let name = g:SchemeList[i-1]
            let menu = g:SchemeList[i]
            if stridx(name,base) != -1
               if !has_key(g:SchemeDoc, name)
                  let g:SchemeDoc[name] = menu
               endif
               call add(res, { 'icase': 1, 'word': name, 'menu': menu})
            endif
            let i -= 2
         endwhile
         return res
      endif
      let line = getline('.')
      let start1 = strridx(line, ' ') + 1
      let start2 = col('.') - 2
      let prefix = line[start1:start2]
      if prefix == ''
         let i = 0
         while i < g:SchemeListLength
            if g:SchemeList[i]  ==  "FUNCTIONS BEGIN"
               return res
            endif
            let name = g:SchemeList[i]
            if stridx(name,base) != -1
               call add(res, {'icase': 1, 'word': name, 'menu': 'var'})
            endif
            let i += 1
         endwhile
      else
         let i = g:SchemeListLength - 1
         while i >= 0
            if g:SchemeList[i] == "FUNCTIONS BEGIN"
               return res
            endif
            let name = g:SchemeList[i-1]
            let menu = g:SchemeList[i]
            if stridx(name,base) != -1
               if !has_key(g:SchemeDoc, name)
                  let g:SchemeDoc[name] = menu
               endif
               call add(res, { 'icase': 1, 'word': name, 'menu': menu})
            endif
            let i -= 2
         endwhile
      endif
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

function! SchemeSymbols(file)
   let file = a:file
   let scriptfile = tempname()
   let code = []
   if &ft == "lisp"
      let code = code + ['(load "/home/a/.sbclrc")']
   elseif &ft == "scheme"
      let code =  code + ['(load "/home/a/.vim/bin/ss.cmd")']
   endif
   let code = code + ['(tags "'. file . '")'] 
   call writefile(code, scriptfile)
   if &ft == "lisp"
      return systemlist('sbcl --script ' . scriptfile)
   elseif &ft == "scheme"
      return systemlist('scheme --script ' . scriptfile)
   endif
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

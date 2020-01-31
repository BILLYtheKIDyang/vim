let g:ExpressionCount = {}
let g:SchemeList = []
function! CountExpression()
   let lines = getbufline('%', 1, "$")
   let ec = 0
   for line in lines
      if len(line) > 0 && line[0] != ' '
         let ec += 1
      endif
   endfor
   return ec
endfunction
function! SchemeComplete(start, base)
   if a:start
      let line = getline('.')
      let start = col('.') - 1
      while start > 0 && IsSchemeWordChar(line[start - 1])
         let start -= 1
      endwhile
      return start
   else
      let base = a:base
      let res = []

      let needComplete = !has_key(g:ExpressionCount, bufname())
      "echom 'has_key' needComplete
      let needComplete = needComplete || CountExpression() != g:ExpressionCount[bufname()] 
      "echom 'count==' needComplete
      let needComplete = needComplete || len(g:SchemeList) == 0
      "echom 'g:SchemeList == []' needComplete
      if needComplete
         let g:ExpressionCount[bufname()] = CountExpression()
         
         let g:splitstring = system('echo "(display split-string)" | scheme -q ' .. expand('~/.vim/bin/ss.cmd'))
         let g:SchemeList = systemlist('echo "(tags \"' .. SchemeFile() .. '\")" | scheme -q ' .. expand('~/.vim/bin/ss.cmd'))
         "let g:splitstring = ';'
         "let g:SchemeList = systemlist('echo "(tags \"' .. SchemeFile() .. '\")" | racket')
      endif
      for nametype in g:SchemeList
         let [name; type] = split(nametype, g:splitstring)
         if name =~ '^.*' .. escape(base, '*\^$.')
            let menu = join(type, '')
            if menu[0] == '('
               let g:SchemeDoc[name] = menu
            endif
            call add(res, { 'icase': 1, 'word': name, 'menu': join(type, '')} )
         endif
      endfor
      for x in getcompletion(base .. '*', 'file')
         call add(res, { 'icase': 1, 'word': x, 'menu': 'file'})
      endfor
      for x in getcompletion(base .. '.*', 'file')
         call add(res, { 'icase': 1, 'word': x, 'menu': 'file'})
      endfor
      for x in getcompletion(base, 'shellcmd')
         call add(res, { 'icase': 1, 'word': x, 'menu': 'shellcmd'})
      endfor
      return res
   endif
endfunction
function! MMC(i1, i2)
   let s1 = a:i1['word']
   let s2 = a:i2['word']
   if s1 == s2
      return 0
   endif
   if s1 > s2
      return 1
   else
      return -1
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
   au BufNewFile,BufRead *.scm,*.ss,*rkt setl omnifunc=SchemeComplete
   au FileType scheme inoremap <buffer>   <Esc>:call GetSchemeDoc() <CR>a<Space>
aug END

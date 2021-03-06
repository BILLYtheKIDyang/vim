function! REPL_is_sub_expression(filetype, line)
   if a:line == '' |  return 1 | endif " 
   if a:line[0] == ' ' || a:line[0] ==  "\t" | return 1 | endif "
   if a:line[0] == '}' || a:line[0] == ')' || a:line[0] == ']' | return 1 | endif "
   if has_key(g:REPL_configs, a:filetype) && has_key(g:REPL_configs[a:filetype], 'continuations')
      for e in g:REPL_configs[a:filetype]['continuations']
         if a:line =~ "^" . e . '\>'
            return 1
         endif
      endfor
   endif
   return 0
endfunction

function! REPL_get_expression()
   let [_, l, _, _] = getpos(".")

   let i = l
   let lines = []
   let line = getline(i)
   while i >= 0 && line == ''
      let i = i - 1
      let line = getline(i)
   endwhile " 跳过前面的空白行


   while i >= 0 && (REPL_is_sub_expression(&filetype, line))
      if len(line) != 0
         call insert(lines, line)
      endif
      let i = i - 1
      let line = getline(i)
   endwhile
   call insert(lines, line) " 搜集所有属于同一缩进的行

   let i = l
   let k = line('$')
   if i == k
      return lines
   endif
   let i = i + 1
   let line = getline(i)

   while i <= k && (REPL_is_sub_expression(&filetype, line))
      if len(line) != 0
         call add(lines, line)
      endif
      let i = i + 1
      let line = getline(i)
   endwhile
   return lines
endfunction

function! REPL_send_expression()
   if !has_key(g:REPL_configs, &filetype)
      return
   endif
   let lines = REPL_get_expression()
   if &filetype == 'perl' ||  (&filetype == 'python' && len(lines) > 1)
      call add(lines, "\<CR>")
   endif

   for line in lines
      call REPL_send_text(&filetype, line)
   endfor
   let g:seen = REPL_get_buttom(&filetype) + len(lines)
endfunction

function! REPL_get_REPL_buffer_number(filetype)
   for i in term_list()
      if term_getstatus(i) == 'finished'
         silent! exe "normal :bd! " . i . "\<CR>" 
      endif
   endfor
   for i in term_list()

      let name = bufname(i)
      if name =~ "^!" . a:filetype
         return i
      endif
   endfor
   return 0
endfunction

function! REPL_start_REPL(filetype) abort
   if !has_key(g:REPL_configs, a:filetype)
      return 0
   endif
   let t =  REPL_get_REPL_buffer_number(a:filetype)
   if t
      return t
   else
      let cmd = has_key(g:REPL_configs, a:filetype) && has_key(g:REPL_configs[a:filetype], 'repl') ?
               \ g:REPL_configs[a:filetype]['repl'] : a:filetype
      let opt = {}
      let opt['term_name'] = '!' . a:filetype
      let opt['hidden'] = 1
      let opt['term_kill'] = 'term'
      let t = term_start(cmd, opt)
      sleep 500ms
      let g:seen = REPL_get_buttom(a:filetype)
      call REPL_start_watch(a:filetype)
      return t
   endif
endfunction

function! REPL_stop_timer()
   for t in timer_info()
      if t['callback'] == function('REPL_handler')
         call timer_stop(t['id'])
      endif
   endfor
endfunction

function! REPL_start_watch(filetype)
   function! REPL_handler(timer) closure
      if !REPL_get_REPL_buffer_number(a:filetype)
         call timer_stop(a:timer)
         return
      endif
      let see = REPL_get_buttom(a:filetype)
      if g:seen != see 
         call REPL_get_print(a:filetype, g:seen)
         let g:seen = see
      endif
   endfunction
   call REPL_stop_timer()
   let timer = timer_start(500, 'REPL_handler', {'repeat': -1})
endfunction
function! REPL_send_text(filetype, text)
   call term_sendkeys(REPL_start_REPL(a:filetype), a:text . "\<CR>")
endfunction

function! REPL_get_buttom(filetype)  abort
   let t = REPL_get_REPL_buffer_number(a:filetype)
   if t
      return term_getcursor(bufname(t))[0] + term_getscrolled(bufname(t))
   endif
endfunction

function! REPL_is_REPL_buffer_seen(bufname)
   let buflist = tabpagebuflist()
   for b in buflist
      if bufname(b) == a:bufname
         return 1
      endif
   endfor
   return 0
endfunction
function! REPL_get_print(filetype, before) abort
   if REPL_is_REPL_buffer_seen('!' . a:filetype)
      return
   endif
   let size = REPL_get_buttom(a:filetype) - a:before
   let t = REPL_get_REPL_buffer_number(a:filetype)
   let base = term_getcursor(bufname(t))[0]
   let i = 0
   let lines = []
   while i < size 
      call add(lines, term_getline(bufname(t), base - size + i))
      let i = i + 1
   endwhile
   call REPL_popup( join(lines, "\n"))
endfunction

function! REPL_popup(str)
   let list = split(a:str, '\n')
   let o = {}
   let o['line'] = 'cursor'
   let o['col']  = 'cursor+' . (len(getline(".")) + 3 -  col(".") )
   let o['moved'] = 'any'
   "let o['border'] = []
   call popup_create(list, o)
endfunction
function! REPL_load(cmd)
   call REPL_send_text(&filetype, a:cmd)
   let g:seen = REPL_get_buttom(&filetype) + 1
endfunction
inoremap <silent> <C-l> <C-o>:call REPL_send_expression()<CR>
noremap <silent> <C-l> :call REPL_send_expression()<CR>

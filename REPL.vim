let g:REPL_configs = {}

let g:REPL_configs['python'] = {}
let g:REPL_configs['python']['ends'] = ['else', 'except'] 
let g:REPL_configs['python']['ps1'] = '>>>'
let g:REPL_configs['python']['ps2'] = '\.\.\.'

if 0
   let g:REPL_configs['vb'] = {}
   let g:REPL_configs['vb']['repl'] = ['wscirpt', 'c:\\Users\\Administrator\\.vim\\work\\vbsh.vbs'] 
   let g:REPL_configs['vb']['ends'] = ['else', 'end'] 
   let g:REPL_configs['vb']['ps1'] = '>>>'
   let g:REPL_configs['vb']['ps2'] = '\.\.\.'
endif

if 1
   let g:REPL_configs['ps1'] = {}
   let g:REPL_configs['ps1']['repl'] = ['powershell'] 
   let g:REPL_configs['ps1']['ends'] = ['"@', 'else', 'end'] 
   let g:REPL_configs['ps1']['ps1'] = 'PS.*>'
   let g:REPL_configs['ps1']['ps2'] = '>>'
endif

let g:REPL_configs['perl'] = {}
let g:REPL_configs['perl']['repl'] = ['perl', 'c:\\Users\\Administrator\\.vim\\work\\eval.pl']
let g:REPL_configs['perl']['ends'] = ['else', 'except'] 
let g:REPL_configs['perl']['ps1'] = 'perl>'
let g:REPL_configs['perl']['ps2'] = '\.\.\.'

let g:REPL_configs['javascript'] = {}
let g:REPL_configs['javascript'] = {}
let g:REPL_configs['javascript']['repl'] = ['node'] 
let g:REPL_configs['javascript']['ends'] = ['else', 'except'] 
let g:REPL_configs['javascript']['ps1'] = '>'
let g:REPL_configs['javascript']['ps2'] = '\.\.\.'

let g:REPL_configs['sml'] = {}
let g:REPL_configs['sml']['repl'] = ['sml.bat']
let g:REPL_configs['sml']['ends'] = ['end', ';'] 
let g:REPL_configs['sml']['ps1'] = '-'
let g:REPL_configs['sml']['ps2'] = '='

let g:REPL_configs['red'] = {}
let g:REPL_configs['red']['repl'] = ['d:\\red\\red.bat', '--cli']
let g:REPL_configs['red']['ends'] = [] 
let g:REPL_configs['red']['ps1'] = '>>'
let g:REPL_configs['red']['ps2'] = '[ '

let g:REPL_configs['java'] = {}
let g:REPL_configs['java']['repl'] = ['jshell']
let g:REPL_configs['java']['ends'] = [] 
let g:REPL_configs['java']['ps1'] = 'jshell>'
let g:REPL_configs['java']['ps2'] = '   ...>'

let g:REPL_configs['ruby'] = {}
let g:REPL_configs['ruby']['repl'] = ['d:\\ruby\\bin\\irb.bat', '--simple-prompt']
let g:REPL_configs['ruby']['ends'] = ['end', 'else'] 
let g:REPL_configs['ruby']['ps1'] = '=>'
let g:REPL_configs['ruby']['ps2'] = '>>'

function! REPL_check_ends(filetype, line)
   if has_key(g:REPL_configs, a:filetype) && has_key(g:REPL_configs[a:filetype], 'ends')
      for e in g:REPL_configs[a:filetype]['ends']
         if a:line =~ "^" . e
            return 1
         endif
      endfor
   else
      return 0
   endif
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


   while i >= 0 && (line == '' || 
            \line[0] == ' ' || line[0] == "\t" || 
            \line[0] == '}' || line[0] == ')' || line[0] == ']' || 
            \REPL_check_ends(&filetype, line))
      " 中间的空行
      " 中间有缩进的行
      " 属于{},[],()表达式的行
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

   while i <= k && (line == '' ||
            \line[0] == ' ' || line[0] == "\t" || 
            \line[0] == '}' || line[0] == ')' || line[0] == ']' || 
            \REPL_check_ends(&filetype, line))
      if len(line) != 0
         call add(lines, line)
      endif
      let i = i + 1
      let line = getline(i)
   endwhile
   return lines
endfunction

function! REPL_get_promptp(filetype)
   let this_line = term_getline(REPL_find_REPL(a:filetype), ".")
   let ps1 = g:REPL_configs[a:filetype]['ps1']
   let ps2 = g:REPL_configs[a:filetype]['ps2']
   if this_line =~ '^' . ps1
      return 1
   elseif this_line =~ '^' . ps2
      return 1
   else
      return 0
   endif
endfunction
function! REPL_send_expression()
   if 0 && &filetype == 'perl'
      let perlcode = REPL_get_expression()
      if len(perlcode) == 1
         call REPL_popup(printf("%s", perleval("" . trim(perlcode[0], ";") . "")))
      else
         call REPL_popup( printf("%s", perleval("" . join(REPL_get_expression(), "\n") . "")))
      endif
      return 
   endif
   if !has_key(g:REPL_configs, &filetype)
      return
   endif
   if !REPL_get_promptp(&filetype)
      echo "REPL: evaluating..."
      return
   endif
   let lines = REPL_get_expression()
   if &filetype == 'perl' || len(lines) > 1
         call add(lines, "")
   endif

   for line in lines
      call REPL_send_text(&filetype, line)
   endfor
   let g:seen = REPL_get_buttom(&filetype) + len(lines)
endfunction

function! REPL_find_REPL(filetype)
   for i in term_list()
      let name = bufname(i)
      if name =~ "^!" . a:filetype
         return i
      endif
   endfor
   return 0
endfunction

function! REPL_start_REPL(filetype) abort
   let t =  REPL_find_REPL(a:filetype)
   if t
      return t
   else
      return term_start(
               \has_key(g:REPL_configs, a:filetype) && has_key(g:REPL_configs[a:filetype], 'repl') ?
               \g:REPL_configs[a:filetype]['repl'] : a:filetype
               \,{
               \ "term_name": "!" . a:filetype
               \,"hidden": 1
               \,"term_finish": "close"
               \,"term_kill": "term"
               \})
   endif
endfunction

function! REPL_set_REPL(filetype)  abort
   if !has_key(g:REPL_configs, a:filetype)
      return 0
   else
      call REPL_start_REPL(a:filetype)
      function! Lazy(timer) closure
         let g:seen = REPL_get_buttom(a:filetype)
         call REPL_start_watch(a:filetype)
      endfunction
      call timer_start(500, 'Lazy', {'repeat': 1})
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
      if !REPL_find_REPL(a:filetype)
         call timer_stop(a:timer)
         return
      endif
      let see = REPL_get_buttom(a:filetype)
      if g:seen != see && REPL_get_promptp(a:filetype)
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

function! REPL_get_buttom(filetype)
   let t = REPL_find_REPL(a:filetype)
   return term_getcursor(bufname(t))[0] + term_getscrolled(bufname(t))
endfunction

function! REPL_buffer_seen(bufname)
   let buflist = tabpagebuflist()
   for b in buflist
      if bufname(b) == a:bufname
         return 1
      endif
   endfor
   return 0
endfunction
function! REPL_get_print(filetype, before) abort
   if REPL_buffer_seen('!' . a:filetype)
      return
   endif
   let size = REPL_get_buttom(a:filetype) - a:before
   let t = REPL_find_REPL(a:filetype)
   let base = term_getcursor(bufname(t))[0]
   let i = 0
   let lines = []
   while i < size 
      call add(lines, term_getline(bufname(t), base - size + i))
      let i = i + 1
   endwhile
   call REPL_popup( join(lines, "\n"))
endfunction
"\col: col('$')+5,
function! REPL_popup(str)
   let list = split(a:str, '\n\+')
   call popup_create(list, 
            \#{ 
            \col: col('$')+5,
            \line: 'cursor', 
            \moved: 'any',
            \} )
endfunction
function! REPL_load(cmd)
   call REPL_send_text(&filetype, a:cmd)
   let g:seen = REPL_get_buttom(&filetype) + 1
endfunction
inoremap <silent> <C-l> <C-o>:call REPL_send_expression()<CR>
noremap <silent> <C-l> :call REPL_send_expression()<CR>
inoremap <silent> <C-k> <C-o>:call REPL_send_text(&filetype, '')<CR>
noremap <silent>  <C-k>:call REPL_send_text(&filetype, '')<CR>
autocmd BufEnter * :call REPL_set_REPL(&filetype)

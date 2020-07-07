set rtp+=d:/YouCompleteMe

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
language messages zh_CN.utf-8
language messages en_US.utf-8
set fileencodings=utf-8,ucs-bom,cp936,big5,gbk
set fileencoding=utf-8
let g:vimtweak_dll_path = expand("~/.vim/vimtweak/vimtweak64.dll")


command! -nargs=1 VimTweakSetAlpha call libcallnr(g:vimtweak_dll_path, "SetAlpha", 0+<args>)
command! VimTweakEnableMaximize call libcallnr(g:vimtweak_dll_path, "EnableMaximize", 1)
command! VimTweakDisableMaximize call libcallnr(g:vimtweak_dll_path, "EnableMaximize", 0)
command! VimTweakEnableTopMost call libcallnr(g:vimtweak_dll_path, "EnableTopMost", 1)
command! VimTweakDisableTopMost call libcallnr(g:vimtweak_dll_path, "EnableTopMost", 0)
command! VimTweakEnableCaption call libcallnr(g:vimtweak_dll_path, "EnableCaption", 1)
command! VimTweakDisableCaption call libcallnr(g:vimtweak_dll_path, "EnableCaption", 0)
function! VT()			     				    		     
   VimTweakSetAlpha 195 
   VimTweakEnableCaption
   VimTweakEnableMaximize
   VimTweakEnableTopMost
endfunction
command! VT call VT()
au!
autocmd BufRead,BufNewFile *.scala set filetype=scala
autocmd BufRead,BufNewFile *.red set filetype=red
autocmd BufWritePost $MYVIMRC source %
autocmd BufWritePre * let &bex=strftime("%y%m%d%H%M") . '.txt'
autocmd BufRead,BufNewFile,BufEnter * set formatoptions=
filetype indent plugin on 
filetype plugin indent on    " required
let g:deoplete#enable_at_startup = 1
let g:fsharp_interactive_bin="fsharpi"
let g:fsharp_xbuild_path="msbuild"
let g:fsharpbinding_debug=1
let g:gcc="g++ -std=c++11"
let g:vim_markdown_math=1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_auto_trigger=1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files =1 
let g:ycm_complete_in_strings=1
let g:ycm_filetype_specific_completion_to_disable = { 'cs': 1 }
let g:ycm_global_ycm_extra_conf='~/.ycm.conf.py'
let g:ycm_key_invoke_completion = '<c-n>'
let g:ycm_min_num_identifier_candidate_chars = 1
let g:ycm_semantic_triggers =  {  'c,cpp,python,ruby,java,go,erlang,perl': ['re!\w{1}'],  'vim,cs,lua,javascript': ['re!\w{1}'],  }
let g:ycm_semantic_triggers['scheme'] = ['re![a-zA-Z0-9+*/&:%^$#@!~=-]{1}']
let g:ycm_semantic_triggers['lisp'] = ['re![a-zA-Z0-9+*/&:%^$#@!~=-]{1}']
let g:ycm_server_log_level = 'info'
let g:ycm_show_diagnostics_ui = 1
"let g:ycm_cache_omnifunc = 0
let mapleader=','
nmap <leader><space> :nohlsearch<cr>
nmap <leader>rc :e ~/.vim/vimrc<cr>
nmap <leader>w :w!<cr>
nnoremap <silent> <leader>, :call MyF4()<CR>
nnoremap  [B :bfirst<cr>
nnoremap  [b :bprevious<cr>
nnoremap  ]B :blast<cr>
nnoremap  ]b :bnext<cr>
runtime plugin/dragvisuals.vim
runtime plugin/foldsearches.vim
runtime plugin/persistentvisuals.vim
runtime plugin/vimpoint.vim
runtime plugin/visualguide.vim
runtime plugin/yankmatches.vim
runtime plugin/EmacsLispComplete.vim
runtime plugin/REPL.vim
packadd! matchit
"set path+=**
set rtp+=~/YouCompleteMe
set ambiwidth=double
set autochdir
set autoindent
set autoread 
set backspace=eol,indent,start
"set backup
"set backupdir=~/vimbackup/
set clipboard+=unnamed " 从寄存器 + 中粘贴与复制, "+p "+y
set cmdheight=2 
set completeopt=menu,menuone
set encoding=utf-8
set expandtab
set ffs=unix,dos,mac
set fileformat=unix
set guioptions=
set hidden 
set hlsearch
set laststatus=2
set lbr
set magic
set mat=2 
set nocompatible              " be iMproved, required
set noerrorbells 
set noswapfile
set novisualbell 
set nowb
set nowrap
set number
set rtp+=.
set ruler 
set shiftwidth=3
set showmatch 
set smartindent
set smarttab
set so=7 
set t_vb=
set tabstop=4
set tw=500
"set undodir=$HOME/vimbackup/
set undofile
set undofile
set whichwrap+=<,>,h,l
set wildmenu 
set wrap
syntax on
vmap  <expr>  <DOWN>   DVB_Drag('down')  
vmap  <expr>  <LEFT>   DVB_Drag('left')  
vmap  <expr>  <RIGHT>  DVB_Drag('right') 
vmap  <expr>  <UP>     DVB_Drag('up')    
vmap  <expr>  D        DVB_Duplicate()   
let g:cmd='' 
let g:clear = ''
func! MyF4()
   :silent :w
   let g:Complete_dict = {}
   :cd %:p:h
   if g:cmd != ""
      execute g:cmd
   elseif &filetype=="c"
      execute "!" .  g:clear . "; echo Compiling... && gcc -std=c11 \"%\" -lm -o %< && echo Running... && ./%< "
   elseif &filetype=="cpp"
      exec "!g++ % && a.exe"
   elseif &filetype=="typescript"
      execute "!" . g:clear . ";tsc % && node %"
   elseif &filetype=="javascript"
      execute "!" . g:clear . "; node %"
   elseif &filetype=="ruby"
      execute "!" . g:clear . "; ruby %"
   elseif &filetype=="basic"
      let currentfilename = WinPath("%:p")
      let exefilename = substitute(currentfilename, '\.\(b\|B\)\(a\|\A\)\(s\|S\)$', '', '')
      execute "!" . g:clear . ";bas %  && ./%<"
   elseif &filetype=="ocaml"
      exe "!" . g:clear . "; ocamlfind ocamlc -linkpkg -thread -package str -package core  -package labltk %  && ./a.out"
   elseif &filetype=="racket"
      :w
      exec "!" . g:clear . ";racket -I typed/racket %"
   elseif &filetype=="perl"
      exec "!" . g:clear . ";perl %"
   elseif &filetype=="elisp"
      call REPL_load("(load-file \"" . WinPath("%:p") . "\")")
      call REPL_send_text("elisp", "(tags)")
   elseif &filetype=="lisp"
      call REPL_load("(load \"" . WinPath("%:p") . "\")")
   elseif &filetype=="scheme"
      call REPL_load('(load "' . WinPath("%:p") . '")')
   elseif &filetype=="vim"
      :so %
   elseif &filetype=="fsharp"
      exe "!" . g:clear . ";fsharpc /nologo % && mono %<.exe"
   elseif &filetype=="python"
      call REPL_load("exec(open(\"" . WinPath("%:p") . "\", encoding='utf-8').read())")
   elseif &filetype=="haskell" || &filetype=="scala"
      call REPL_load(":load " . WinPath("%:p"))
   elseif &filetype=="java"
      call REPL_load("/open " . WinPath("%:p"))
   elseif &filetype == "dosbatch"
      call REPL_load(WinPath("%:p"))
   elseif &filetype == "sh"
      call REPL_load("". WinPath("%:p"))
   elseif &filetype == "sml"
      call REPL_load('use "' . WinPath("%:p") . '";')
   else
      silent !start "%"
   endif
   let g:Complete_data=[]
   call M()
endfunc
function! WinPath(p)
   return substitute(expand(a:p), '\\', '\\\\', 'g')
endfunction


func! Fqb()
   :w
   execute "!/home/a/.local/qb64/qb64 %:p"
endfunc
call plug#begin('~/vim_plug')
Plug 'mattn/emmet-vim'
"Plug 'kovisoft/slimv'
Plug 'l04m33/vlime', {'rtp': 'vim/'}
call plug#end()
if has('win32')
else
   let g:coc_node_path="/usr/bin/node"
endif
"let moria_style='white'
"let moria_monochrome=1
"let moria_fontface='mixed'
let g:clojure_fuzzy_indent_patterns=['^.']
if has('win32')
   set guifont=Consolas:h12:cANSI:qDRAFT
else
   set guifont=Droid\ Sans\ Mono\ 10
endif

let g:ycm_language_server = []
"let g:ycm_language_server += [{ 'name': 'vim',      'filetypes': [ 'vim' ],      'cmdline': [ "vim-language-server", '--stdio' ]   }]
colorscheme zmrok
colorscheme molokai_dark
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
set rtp+=~/tabular
"set rtp+=~/Desktop/lisper-vim
"set rtp+=/home/a/Desktop/slimv
augroup VIM
   au!
   autocmd FileType vim setlocal omnifunc=MyVimScriptComplete
   autocmd BufWritePost *.vim source %
   autocmd BufWritePost ~/.vim/vimrc source %
augroup END
function! ScrollOtherSide(k)
   let t = []
   for w in getwininfo()
      let t += [{'number':  w['winnr'], 'size': w['width'] * w['height'] }]
   endfor
   let t = filter(t, 'v:val["number"] != winnr()')
   let t = sort(t, {i1, i2 -> i1['size'] == i2['size'] ? 0 : i1['size'] <  i2['size']   ? 1 :  -1})
   if len(t) < 1
      return
   else
      exec t[0]['number'] . "wincmd w"
      if a:k == 'j'
         exec "normal \<c-e>"
      elseif a:k == 'k'
         exec "normal \<c-y>"
      endif
      "exec "normal " . a:k
      exec "wincmd p"
   endif
endfunction
nnoremap <silent> <c-j> :call ScrollOtherSide('j') <CR>
nnoremap <silent> <c-k> :call ScrollOtherSide('k') <CR>
function! ColorMe()
   let colors =reverse( getcompletion('', 'color'))
   let k = len(colors)
   let i = 0
   function! ColorHandler(timer) closure
      if i == k
         let i = 0
      else
         let i = i + 1
      endif
      try 
         call popup_create(colors[i], #{
                  \ line: 1,
                  \ col: "cursor+" . (getwininfo()['variables']['width'] - getcurpos()[2]  - 30)
                  \ ,minwidth: 20,
                  \ time: 3000,
                  \ tabpage: -1,
                  \ zindex: 300,
                  \ drag: 1,
                  \ highlight: 'WarningMsg',
                  \ border: [],
                  \ close: 'click',
                  \ padding: [0,1,0,1],
                  \ })
         exec 'colorscheme ' . colors[i]
      catch
      endtry
   endfunction
   let timer = timer_start(30000, 'ColorHandler',  { 'repeat':  -1 })
endfunction
call ColorMe()
let g:REPL_configs = {}
let g:REPL_configs['java']                        = {}
let g:REPL_configs['java']['continuations']       = ['else', 'catch']
let g:REPL_configs['java']['repl']                = ['jshell']
let g:REPL_configs['javascript']                  = {}
let g:REPL_configs['javascript']['continuations'] = ['else', 'except']
let g:REPL_configs['javascript']['repl']          = ['node']
let g:REPL_configs['lisp']                        = {}
let g:REPL_configs['lisp']['repl']                = ['sbcl', '--userinit', expand("~/.vim/sbclrc.lisp")]
let g:REPL_configs['perl']                        = {}
let g:REPL_configs['perl']['continuations']       = ['else', 'except']
let g:REPL_configs['perl']['repl']                = ['perl', expand("$HOME/.vim/bin/eval.pl")]
let g:REPL_configs['lisp']['repl']                = [expand("$HOME/.vim/bin/elisp.cmd")]
let g:REPL_configs['python']                      = {}
let g:REPL_configs['python']['continuations']     = ['else', 'except']
let g:REPL_configs['scheme']                      = {}
let g:REPL_configs['scheme']['repl']              = ['scheme', expand("~/.vim/bin/ss.cmd")]
let g:REPL_configs['scala']                       = {'repl': ['scala'] }
let g:REPL_configs['java']                        = {'repl': ['jshell'] }
let g:REPL_configs['haskell']                     = {'repl': ['ghci'] }
let g:REPL_configs['sml']                         = {'repl': ['smlnj']}
let g:REPL_configs['sh']                 = {'repl': ['bash'], 'continuations': ['done', 'esac', 'fi']}
let g:REPL_configs['ruby']               = {'repl': ['irb.cmd'], 'continuations': ['end']}


let s:lsp = '~/lsp-examples'
let g:ycm_language_server = [ { 'name': 'ruby', 'cmdline': [ expand( s:lsp . '/ruby/bin/solargraph.bat' ), 'stdio' ], 'filetypes': [ 'ruby' ], }, ]

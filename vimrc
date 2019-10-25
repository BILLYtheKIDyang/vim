au!
autocmd BufRead,BufNewFile *.scala set filetype=scala
autocmd BufRead,BufNewFile *.red set filetype=red
autocmd BufWritePost $MYVIMRC source %
autocmd BufWritePost ~/.vim/vimrc source %
autocmd BufWritePost *.vim source %
autocmd BufWritePre * let &bex=strftime("%y%m%d%H%M") . '.txt'
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType * set formatoptions-=c formatoptions-=r formatoptions-=o
filetype indent plugin on 
filetype off                 " required
filetype plugin indent on    " required
if has("gui_running") |let g:clear=""| else| let g:clear="clear "| endif
let g:cargs=""
let g:cmd=""
let g:cp="-cp ."
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
let g:ycm_global_ycm_extra_conf='~/.ycm.conf.py'
let g:ycm_key_invoke_completion = '<c-n>'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_semantic_triggers =  {  'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],  'cs,lua,javascript': ['re!\w{2}'],  }
let g:ycm_server_log_level = 'info'
let g:ycm_show_diagnostics_ui = 1
let g:ycm_filetype_specific_completion_to_disable = { 'cs': 1 }
let mapleader=','
nmap <leader><space> :nohlsearch<cr>
nmap <leader>rc :e ~/.vim/vimrc<cr>
nmap <leader>w :w!<cr>
nnoremap <leader>= :!emacsasformater %<CR>
nnoremap <leader>Y :let g:ycm_auto_trigger=1<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>scm :tabnew ~/.vim/ftplugin/scheme.vim<CR>
nnoremap <leader>y :let g:ycm_auto_trigger=0<CR>
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
"runtime plugin/LispIndent.vim
"set path+=**
set rtp+=~/YouCompleteMe
set formatoptions-=ro " 在注释下开新行时，不要自作聪明添加注释符号
set ambiwidth=double
set autochdir
set autoindent
set autoread 
set backspace=eol,indent,start
set backup
set backupdir=~/vimbackup/
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
set tags=./tags;,tags
set tw=500
set undodir=$HOME/vimbackup/
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

func! MyF4()
   :silent :w
   :cd %:p:h
   if g:cmd != ""
      execute g:cmd
   elseif &filetype=="c"
      execute "!" .  g:clear . "; echo Compiling... && gcc -std=c11 \"%\" -lm && echo Running... && ./a.out"
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
   elseif &filetype=="lisp"
      call term_sendkeys(term_list()[0], "(load \"" . WinPath("%:p") . "\")\<CR>")
   elseif &filetype=="scheme"
      silent call term_sendkeys(term_list()[0], "(tags)\<CR>")
      call term_sendkeys(term_list()[0], "(load \"" . WinPath("%:p") . "\")\<CR>")
      call GetTerminalReplPrint(TermGetButtom() + 2)
   elseif &filetype=="vim"
      :so %
   elseif &filetype=="fsharp"
      exe "!" . g:clear . ";fsharpc /nologo % && mono %<.exe"
   elseif &filetype=="python"
      call REPL_load("exec(open(\"" . WinPath("%:p") . "\").read())")
   elseif &filetype=="clojure"
      call term_sendkeys(term_list()[0], "(load-file \"" . WinPath("~/.vim/.cljrc") . "\")\<CR>")
      call term_sendkeys(term_list()[0], "(tags)\<CR>")
      call term_sendkeys(term_list()[0], "(load-file \"" . WinPath("%:p") . "\")\<CR>")
      let bttm = TermGetButtom()
      call GetTerminalReplPrint(bttm)
   elseif &filetype=="haskell" || &filetype=="scala"
      call REPL_load(":load " . WinPath("%:p"))
   elseif &filetype=="java"
      execute "!" . g:clear . ";javac % && java %<"
   elseif &filetype == "dosbatch"
      call REPL_load(WinPath("%:p"))
   elseif &filetype == "sh"
      call term_sendkeys(term_list()[0], "zsh " . WinPath("%:p") . "\<CR>")
      call GetTerminalReplPrint('', '> ')
   else
      echom "`let g:cmd='!???`"
   endif

endfunc
function! WinPath(p)
   return substitute(expand(a:p), '\\', '\\\\', 'g')
endfunction


so ~/.vim/REPL.vim
func! Fqb()
   :w
   execute "!/home/a/.local/qb64/qb64 %:p"
endfunc
call plug#begin('d:/vim_plug')
" Use release branch
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'sheerun/vim-polyglot'
call plug#end()

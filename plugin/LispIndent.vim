autocmd FileType clojure,lisp,scheme,racket,emacs-lisp inoremap ) )<Esc>%:echo getline(".") <CR>%a
autocmd FileType clojure,lisp,scheme,racket,emacs-lisp inoremap ] ]<Esc>%:echo getline(".") <CR>%a
autocmd FileType clojure,lisp,scheme,racket,emacs-lisp inoremap } }<Esc>%:echo getline(".") <CR>%a
autocmd FileType clojure,lisp,scheme,racket,emacs-lisp setlocal debug=msg
autocmd FileType clojure,lisp,scheme,racket,emacs-lisp setlocal equalprg=
autocmd FileType clojure,lisp,scheme,racket,emacs-lisp setlocal indentexpr=LI()
autocmd FileType clojure,lisp,scheme,racket,emacs-lisp setlocal noai
autocmd FileType clojure,lisp,scheme,racket,emacs-lisp setlocal nolisp
autocmd FileType clojure,lisp,scheme,racket,emacs-lisp setlocal nosmartindent
python3<<EOS
import sys
import vim
exec(open(vim.eval('expand("<sfile>:h")') + '/LispIndent.py').read())
EOS
function!  LI()
   if line(".") == 1
      return -1
   else
      return py3eval("ind(vim.current.buffer.range(1,vim.current.window.cursor[0]-1),[])")
   endif
endfunction
if !has('mzscheme')
   finish
endif
function! UseMZScheme()
mzscheme<<EOS
(require (prefix-in vim- 'vimext))
;(load (string-append (bytes->string/utf-8 (vim-eval  "expand(\"<sfile>:h\")")) "/LispIndent.scm"))
(load "/home/a/.vim/plugin/LispIndent.scm")
(define ind-list '(("" . 1) ("or" . 4) ("[" . 1) ("and" . 5) ("if" . 4))) 
(define pair-list '("cond" "case"))
EOS

function!  LI()
mzscheme<<EOS
(define in-string? #f)
(define in-bar? #f)
(define in-block? #f)
(define buff
   (map bytes->string/utf-8
      (vim-get-buff-line-list 1 (sub1 (car (vim-get-cursor))))))
EOS

if line(".") == 1
   return -1
else
   return mzeval("(ind buff '())")
endif
endfunction
endfunction

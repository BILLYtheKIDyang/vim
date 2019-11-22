;; @echo off
;; d:/emacs/bin/emacs -nw --eval "(setf xfile \"%1\")" --eval "(message xfile)" -l %~f0 
;; goto :eof
;; vim:ft=elisp:syntax=lisp:lisp
;(load "~/.emacs.d/lisp/htmlize.el")
(find-file xfile)
(message xfile)
(setf buffer (concat (file-name-base xfile) "." (file-name-extension xfile)))
(message buffer)
(switch-to-buffer buffer)
(htmlize-buffer)
(switch-to-buffer  (concat buffer ".html"))
(write-file (concat buffer ".html") nil)
(kill-emacs)

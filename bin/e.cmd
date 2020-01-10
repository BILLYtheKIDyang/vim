;; @echo off
;; d:/emacs/bin/emacs -nw --eval "(setf xfile \"%1\")" --eval "(message xfile)" -l %~f0 
;; goto :eof
;; vim:ft=elisp:syntax=lisp:lisp
(find-file xfile)
(setf buffer (concat (file-name-base xfile) "." (file-name-extension xfile)))
(setf htmlfile (concat buffer ".html"))
(setf imgfile (concat buffer ".png"))

(switch-to-buffer buffer)
(htmlize-buffer)
(switch-to-buffer  (concat buffer ".html"))
(goto-line 9)
(insert "\tfont-size:20pt;\n")
(write-file (concat buffer ".html") nil)
(shell-command
  (concat "wkhtmltoimage "
    htmlfile " "  imgfile))
(kill-emacs))

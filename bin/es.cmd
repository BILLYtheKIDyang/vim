;;@echo off
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof
;; vim:ft=elisp:syntax=lisp:lisp
(require 'cl)
(mapatoms
  (lambda (x)
    (princ 
      (format "%s,%s\n"
         x 
         (ignore-errors
           (let ((doc (elisp-get-fnsym-args-string x)))
              (substring doc (+ 2 (search ":" doc)))))))))

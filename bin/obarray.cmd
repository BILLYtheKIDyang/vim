;;@echo off
;;d:/emacs/bin/emacs --script %~f0
;;goto :eof
;; vim:ft=elisp:syntax=lisp:lisp

(setf symbols '())
(mapatoms (lambda (x) (push x symbols)))
(princ "vim:ft=help:lisp\n")
(dolist (x symbols)
  (princ "\n")
  (princ (make-string 80 ?-))
  (princ "\n")
  (let* ((ss (- 80 (+ (* 2 (length (symbol-name x))) 2)))
         (spaces (if (> ss 0) (make-string ss ?\s) 1)))
        
  (princ 
    (format 
      "%s%s*%s*\n\n%s\n%s"
      x 
      spaces
      x
      (ignore-errors (documentation x))
      (ignore-errors (documentation-property x 'variable-documentation))))))
